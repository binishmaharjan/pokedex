# InjectableGen

DIKitの
- Injectable
- FactoryMethodInjectable

の実装をコード生成によってサポートするツール。

## 使い方

```swift
final class ViewController: AutoInjectable {

    init(viewModel: ViewModel) {
        ...
    }
}
```

- class / struct / enum の宣言ブロックに `AutoInjectable` をつける
- イニシャライザもしくはファクトリメソッドを実装する

のみ

## 仕組み

プロジェクトの Swift ファイルを全て読み取り**2つのファイルを自動生成する。**

### Injectable.generated.swift

- Injectable
- FactoryMethodInjectable

を実装するコード。

AutoInjectable な class / struct / enum 内の最初のイニシャライザもしくはファクトリメソッドの引数から DIKit の Dependency を逆算して自動で FactoryMethodInjectable を生成する。

↓コード生成例

```swift
extension APIKitHTTPClient: FactoryMethodInjectable {

    struct Dependency {
        
        let session: Session
        

        init(session: Session) {
            self.session = session
            
        }
    }
    
    static func makeInstance(dependency: Dependency) -> APIKitHTTPClient {
        APIKitHTTPClient(session: dependency.session)
    }
}
```

### DummyInjectable.generated.swift

もう1つは DIKit に自動生成するコードを認識させるためのダミーコード。

↓コード生成例

```swift
struct APIKitHTTPClient: FactoryMethodInjectable {

    struct Dependency {
        
        let session: Session
        
    }
    
    static func makeInstance(dependency: Dependency) -> APIKitHTTPClient { fatalError() }
}
```

DIKit は extension で実装された Injectable / FactoryMethodInjectable は無視されるという仕様になっているため、実は最初に述べたコードは **DIKitに認識されない**。  

それを補助するのがこのコードの役割。

**DIKit を実行した後は不要なので削除する。**