FROM alpine:edge AS base
WORKDIR /root
SHELL ["/bin/sh", "-c"]

RUN apk add git neovim man-pages alpine-sdk zsh curl --update

# install deps needed by neovim
RUN apk add wget gzip neovim-doc ripgrep nodejs npm zsh-autosuggestions zsh-syntax-highlighting --update

# pre-download lazy.nvim
RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /root/.local/share/nvim/lazy/lazy.nvim

# install lunarvim dependencies
RUN apk add yarn python3 cargo bash --update

# install tree-sitter-cli with cargo because `npm i tree-sitter-cli` fails on
# apple silicon. Install other rust dependencies while at it.
RUN cargo install tree-sitter-cli fd-find ripgrep
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
# install lunarvim
RUN su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies"

COPY .zshrc .zshrc
COPY config.lua /root/.config/lvim/config.lua

# copy these hidden folders during development for faster
# loading of lazy.nvim, mason, and treesitter
#COPY .cache /root/.cache
#COPY .local /root/.local

FROM base
SHELL ["/bin/zsh", "-c"]
WORKDIR /mount
#COPY lvim /root/.config/lvim
CMD ["/bin/zsh"]
