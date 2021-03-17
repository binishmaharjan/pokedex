# dikitgen を更新するスクリプト
SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR

git clone https://github.com/ishkawa/DIKit.git
cd DIKit
make build

cp -f ".build/release/dikitgen" "../dikitgen"

cd ../
rm -rf DIKit