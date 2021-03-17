SCRIPT_DIR=$(cd $(dirname $0); pwd)
App=$SCRIPT_DIR/../../App
DI=$App/Pokedex/DI

$SCRIPT_DIR/InjectableGenerator $App -i $DI/Injectable.generated.swift -d $DI/DummyInjectable.generated.swift

$SCRIPT_DIR/dikitgen $App --exclude Carthage --exclude Pods > $DI/AppResolver.generated.swift

rm $DI/DummyInjectable.generated.swift
