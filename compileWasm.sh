#!/bin/zsh

# Check if emcc exists
if ! command -v emcc &> /dev/null
then
    echo "emcc could not be found"
    
    # Determine OS
    case "$(uname -s)" in
        Darwin)
            echo "Installing emscripten on MacOS using Homebrew"
            if ! command -v brew &> /dev/null
            then
                echo "Homebrew is not installed. Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install emscripten
            ;;

        Linux)
            echo "Installing emscripten on Linux using apt"
            if ! command -v apt &> /dev/null
            then
                echo "apt is not available on this system. Unable to install emscripten."
                exit 1
            fi
            sudo apt-get update
            sudo apt-get install emscripten
            ;;

        *)
            echo "Unable to determine OS or OS not supported"
            exit 1
            ;;
    esac
fi


rm -f *.o && make wasm