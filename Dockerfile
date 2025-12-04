FROM r-base:4.5.1
USER root

# Avoid interactive apt prompts
ENV DEBIAN_FRONTEND=noninteractive


# -------------------------------------------------------------------
# System dependencies (R, GSVA deps, Java, dotnet, tools, etc.)
# -------------------------------------------------------------------
RUN rm -f /etc/apt/apt.conf.d/default-release || true && \
    apt-get update && \
    apt-get install -y \
        zsh \
        fzf \
        cmatrix \
        lazygit \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libmagick++-dev \
        curl \
        wget \
        git \
        unzip \
        bzip2 \
        ca-certificates \
        nodejs npm \
        openjdk-17-jdk && \
        rm -rf /var/lib/apt/lists/*


#
# # -------------------------------------------------------------------
# # Install dotnet SDK 8.0
# # -------------------------------------------------------------------
# RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb \
#     -O /tmp/packages-microsoft-prod.deb && \
#     dpkg -i /tmp/packages-microsoft-prod.deb && \
#     rm /tmp/packages-microsoft-prod.deb && \
#     apt-get update && \
#     apt-get install -y dotnet-sdk-8.0 && \
#     rm -rf /var/lib/apt/lists/*
#
# # -------------------------------------------------------------------
# # Install Miniconda (non-interactive)
# # -------------------------------------------------------------------
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#     -O /tmp/miniconda.sh && \
#     bash /tmp/miniconda.sh -b -p /opt/miniconda && \
#     rm /tmp/miniconda.sh
#
# # Put base conda on PATH for runtime
# ENV PATH="/opt/miniconda/bin:${PATH}"
#
# # Use bash so conda behaves nicely in RUN commands
# SHELL ["bash", "-lc"]
#
# # -------------------------------------------------------------------
# # Create 'carafe' conda environment (AlphaPeptDeep DIA env)
# # -------------------------------------------------------------------
# RUN wget https://raw.githubusercontent.com/wenbostar/alphapeptdeep_dia/refs/heads/main/conda_environment.yml \
#     -O /tmp/conda_environment.yml && \
#     /opt/miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
#     /opt/miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
#     /opt/miniconda/bin/conda env create -f /tmp/conda_environment.yml -y && \
#     /opt/miniconda/bin/conda clean -afy && \
#     rm /tmp/conda_environment.yml
#
# # Make the carafe env the default "active" env via PATH (Docker-style activation)
# ENV PATH="/opt/miniconda/envs/carafe/bin:${PATH}"
#
# # -------------------------------------------------------------------
# # Download Carafe binary release and unpack under /opt
# # -------------------------------------------------------------------
# RUN wget https://github.com/Noble-Lab/Carafe/releases/download/v1.1.2/carafe-1.1.2.zip -O /tmp/carafe-1.1.2.zip && \
#     unzip /tmp/carafe-1.1.2.zip -d /opt && \
#     rm /tmp/carafe-1.1.2.zip
#
# # -------------------------------------------------------------------
# # Download DIA-NN
# # -------------------------------------------------------------------
# ARG DIANN_VERSION="2.2.0"
# # RUN wget https://github.com/vdemichev/DiaNN/releases/download/2.0/DIA-NN-${DIANN_VERSION}-Academia-Linux-Preview.zip \
# RUN wget https://github.com/vdemichev/DiaNN/releases/download/2.0/DIA-NN-${DIANN_VERSION}-Academia-Linux.zip \
#     -O /tmp/diann-${DIANN_VERSION}.zip && \
#     unzip /tmp/diann-${DIANN_VERSION}.zip -d / && \
#     chmod -R 775 /diann-${DIANN_VERSION} && \
#     rm /tmp/diann-${DIANN_VERSION}.zip
#
# # -------------------------------------------------------------------
# # Install Pandoc
# # -------------------------------------------------------------------
# ARG PANDOC_VERSION="3.3"
# RUN wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb \
#         -O /tmp/pandoc.deb && \
#     dpkg -i /tmp/pandoc.deb && \
#     rm /tmp/pandoc.deb
#
# # -------------------------------------------------------------------
# # Install R packages
# # -------------------------------------------------------------------
# # Copy R package install script
# COPY scripts/install_packages.R /usr/local/lib/install_packages.R
# RUN Rscript /usr/local/lib/install_packages.R

# -------------------------------------------------------------------
# Neovim
# -------------------------------------------------------------------
# Install latest Neovim release
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    tar xzf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux-x86_64.tar.gz
COPY dotfiles/nvim /root/.config/nvim
# RUN nvim --headless "+Lazy! sync" +qa
# RUN nvim --headless "+TSUpdateSync" +qa
# RUN nvim --headless "+TSInstallSync r" +qa
# RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+Lazy! sync" \
    "+lua vim.treesitter.get_parser(0, 'r')" \
    "+qa"




# -------------------------------------------------------------------
# zsh
# -------------------------------------------------------------------
# Install zinit at build time
RUN mkdir -p /root/.local/share/zinit && \
    git clone https://github.com/zdharma-continuum/zinit.git \
        /root/.local/share/zinit/zinit.git
# Set environment defaults
ENV ZDOTDIR=/root
ENV TERM=xterm-256color
WORKDIR /root
COPY dotfiles/zshrc /root/.zshrc
COPY dotfiles/zsh /root/.config/zsh

# Set build-time shell (optional)
SHELL ["/usr/bin/zsh", "-lc"]
# Set runtime shell — this prevents auto-launch into R
CMD ["zsh"]
