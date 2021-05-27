#!/bin/bash

function update {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "[ INFO ] Atualizando repositorios ..."

        sudo apt-get update

        echo "[ INFO ] Instalando python e pip"

        sudo apt-get install python3
        sudo apt-get install python3-pip
        sudo apt-get install unzip

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "[ INFO ] Instalando python e pip"

        brew install python3
        brew install python3-pip
        brew install unzip

    fi

    echo "[ INFO ] Instalando dependencias"
}

if [ $# -lt 1 ]
then
    update
    pip install --no-cache -r requirements.txt

else
    case $1 in
    "-h") echo "Isto seria uma ajuda... Mas fiquei com preguiça de escrevê-la."
            return 1
            ;;
    "-v") echo "Versão 0.1."
            return 1
            ;;
    "-d") echo "[ INFO ] Realizando Download do Git-Hub"
            update

            wget https://github.com/JN513/command-line-image-editor/archive/main.zip 
            unzip main.zip               
            
            rm main.zip
            cd command-line-image-editor-main/
            pip install --no-cache -r requirements.txt
            ;;
    *) echo "Opção inválida!"
        exit 1
        ;;
    esac
fi

BASHRC=~/.bashrc

ZSHRC=~/.zshrc

DIR_CHAMADA="${PWD}"

if [ -e $BASHRC ] 
then
    echo "tem bash"
    sudo echo "alias edit='python $DIR_CHAMADA/main.py'" >> $BASHRC
fi

if [ -e $ZSHRC ] 
then
    echo "tem zsh"
    sudo echo "alias edit='python $DIR_CHAMADA/main.py'" >> $ZSHRC
fi