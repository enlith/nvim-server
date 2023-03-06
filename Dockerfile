FROM alpine:latest

ARG username
ARG password

# Install dependencies
RUN apk add --no-cache make
RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache \
    bash \
    curl \
    nodejs \
    npm \
    tmux \
    python3 \
    neovim
RUN apk add --no-cache build-base git

# Install Wetty
RUN npm install -g wetty

# Create a user for the service
RUN adduser --disabled-password --gecos "" ${username}
RUN echo "${username}:${password}" | chpasswd
RUN apk add --no-cache sudo \
    && echo "${username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${username}

# Copy the tmux and neovim configurations
COPY .tmux.conf /home/${username}/.tmux.conf
COPY init.vim /home/${username}/.config/nvim/init.vim

# Set the ownership of the configuration files
RUN chown -R ${username}:${username} /home/${username}

# Install Neovim plugin
USER ${username}
RUN curl -fLo /home/${username}/.local/share/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim --headless +PlugInstall +qall

ENV TERM xterm-256color

USER root
# Expose the default Wetty port
EXPOSE 3000

# Start the Wetty service when the container starts
CMD ["wetty", "--port", "3000", "--sshhost", "localhost", "--sshport", "22", "--sshuser", "root", "--sshauth", "password", "--tmux", "/usr/bin/tmux", "--", "/usr/bin/nvim"]

