#!/usr/bin/env bash

# Function to print the loading screen
print_loading_screen() {
    echo "\033[1;34m"
    echo "==============================================="
    echo "      🚀 Developed by Christopher Trauco        "
    echo "      Data Engineer 🧑 | OGx Consulting 🌐"
    echo "==============================================="
    echo "\033[0m"
    echo "🌐 Discover More: https://www.WeAreOGx.com"
    echo "📧 Email: example@ogx.com"
    echo "📞 Phone: (123) 456-7890"
    sleep 1

    echo "\033[1;32m"
    echo "✨ Initializing..."
    sleep 1

    echo -n "⚙️ Loading modules"
    for i in {1..10}; do
        echo -n "."
        sleep 0.2
    done
    echo ""

    echo -n "🔧 Setting up the environment"
    for i in {1..10}; do
        echo -ne "\033[1;3${i}m.\033[0m"
        sleep 0.2
    done
    echo ""

    echo "\033[1;35m🚀 Almost done...\033[0m"
    sleep 1
    echo "\033[1;33m🎉 Ready!\033[0m"
}

# Function to install pyenv
install_pyenv() {
    if ! command -v pyenv &> /dev/null; then
        echo "\033[1;35m🚀🌈 Installing pyenv...\033[0m"
        curl https://pyenv.run | bash

        # Add pyenv to bash profile
        echo -e '\n# pyenv setup 🧑‍💻🕶️' >> ~/.bashrc
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

        source ~/.bashrc
    else
        echo "\033[1;32m✅ Pyenv is already installed. 🦄✨\033[0m"
    fi
}

# Function to install dependencies for pyenv
install_dependencies() {
    echo "\033[1;35m🔍 Installing dependencies... 🔬\033[0m"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
                            libbz2-dev libreadline-dev libsqlite3-dev wget curl \
                            llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                            libffi-dev liblzma-dev python-openssl git
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install openssl readline sqlite3 xz zlib
    else
        echo "\033[1;31m❌ Unsupported OS type: $OSTYPE\033[0m"
        exit 1
    fi
    echo "\033[1;32m✅ Dependencies installed. 🧪\033[0m"
}

# Function to create recommended directory structure
create_directory_structure() {
    echo "\033[1;35m📁 Creating directory structure... 🏗️\033[0m"
    mkdir -p ~/gcp_projects/{Development,Testing,Production}
    mkdir -p ~/gcp_projects/Development/{notebooks,scripts,venv}
    mkdir -p ~/gcp_projects/Testing/{notebooks,scripts,venv}
    mkdir -p ~/gcp_projects/Production/{notebooks,scripts,venv}
    echo "\033[1;32m✅ Directory structure created at ~/gcp_projects. 🏠\033[0m"
}

# Function to setup pyenv and python virtual environment
setup_python_env() {
    echo "\033[1;35m🐍 Setting up Python environment... 🧑‍💻\033[0m"
    pyenv install 3.10.4
    pyenv shell 3.10.4
    python -m venv ~/gcp_projects/Development/venv
    python -m venv ~/gcp_projects/Testing/venv
    python -m venv ~/gcp_projects/Production/venv
    echo "\033[1;32m✅ Python virtual environments created. 🦄\033[0m"
}

# Function to install recommended python packages
install_python_packages() {
    echo "\033[1;35m📦 Installing recommended Python packages... 🧙‍♂️\033[0m"
    source ~/gcp_projects/Development/venv/bin/activate
    pip install --upgrade pip
    pip install jupyter pandas numpy matplotlib scikit-learn
    deactivate
    source ~/gcp_projects/Testing/venv/bin/activate
    pip install --upgrade pip
    pip install jupyter pandas numpy matplotlib scikit-learn
    deactivate
    source ~/gcp_projects/Production/venv/bin/activate
    pip install --upgrade pip
    pip install jupyter pandas numpy matplotlib scikit-learn
    deactivate
    echo "\033[1;32m✅ Recommended Python packages installed. 🧬✨\033[0m"
}

# Function to create shell scoped aliases
create_aliases() {
    echo "\033[1;35m🔧 Creating aliases for virtual environment management... 🛠️\033[0m"
    echo -e '\n# aliases for virtual environment management 👨‍💻' >> ~/.bashrc
    echo 'alias pyenv_shell="pyenv shell"' >> ~/.bashrc
    echo 'alias pydie="deactivate"' >> ~/.bashrc
    echo 'alias pyup="source ~/gcp_projects/Development/venv/bin/activate"' >> ~/.bashrc

    source ~/.bashrc
    echo "\033[1;32m✅ Aliases created. 🦄\033[0m"
}

# Function to delete all resources and uninstall packages
delete_resources() {
    echo "\033[1;31m🗑️ Deleting all resources... 💥\033[0m"
    rm -rf ~/gcp_projects
    rm -rf ~/.pyenv
    sed -i '/# pyenv setup 🧑‍💻🕶️/d' ~/.bashrc
    sed -i '/export PATH="$HOME\/.pyenv\/bin:$PATH"/d' ~/.bashrc
    sed -i '/eval "$(pyenv init --path)"/d' ~/.bashrc
    sed -i '/eval "$(pyenv init -)"/d' ~/.bashrc
    sed -i '/eval "$(pyenv virtualenv-init -)"/d' ~/.bashrc
    sed -i '/# aliases for virtual environment management 👨‍💻/d' ~/.bashrc
    sed -i '/alias pyenv_shell="pyenv shell"/d' ~/.bashrc
    sed -i '/alias pydie="deactivate"/d' ~/.bashrc
    sed -i '/alias pyup="source ~/gcp_projects\/Development\/venv\/bin\/activate"/d' ~/.bashrc
    echo "\033[1;32m✅ All resources deleted and packages uninstalled. 🔥\033[0m"
}

# Function to display the main menu
main_menu() {
    print_loading_screen

    echo "\033[1;34m💻 Welcome to the Environment Setup Script! 🎉\033[0m"
    echo "\033[1;34mPlease choose an option:\033[0m"
    echo "\033[1;34m1) Setup and install the environment\033[0m"
    echo "\033[1;34m2) Skip setup and load the existing environment\033[0m"
    echo "\033[1;34m3) Delete all resources and uninstall packages to start fresh\033[0m"
    echo "\033[1;34mq) Quit\033[0m"

    read -p "Enter your choice: " choice
    case "$choice" in 
        1 ) 
            install_dependencies
            install_pyenv
            create_directory_structure
            setup_python_env
            create_aliases
            prompt_install_packages
            ;;
        2 )
            echo "\033[1;35m🔄 Loading existing environment... 🛠️\033[0m"
            source ~/.bashrc
            ;;
        3 )
            delete_resources
            ;;
        q|Q )
            echo "\033[1;35m👋 Goodbye!\033[0m"
            exit 0
            ;;
        * )
            echo "\033[1;31m❌ Invalid choice.\033[0m"
            main_menu
            ;;
    esac
}

# Function to prompt the user to install python packages
prompt_install_packages() {
    read -p "Do you want to install recommended Python packages (jupyter, pandas, numpy, etc.)? (y/n): " choice
    case "$choice" in 
        y|Y ) install_python_packages;;
        n|N ) echo "\033[1;31m🚫 Skipping Python packages installation. 👋\033[0m";;
        * ) echo "\033[1;31m❌ Invalid choice\033[0m"
    esac
}

# Call the main menu function
main_menu
