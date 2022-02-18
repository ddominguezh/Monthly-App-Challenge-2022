import UIKit

struct JsonImage: Encodable {
    var name: String
    var image: String
}

private var items: [JsonImage] = [JsonImage]()

private func films(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        FilmAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.title, image: imageApi.getUrlImage(name: $0.title)))
                }
                if !result.next.isEmpty {
                    films(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        FilmAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.title, image: imageApi.getUrlImage(name: $0.title)))
                }
                if !result.next.isEmpty {
                    films(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}

private func species(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        SpeccyAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    species(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        SpeccyAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    species(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}

private func vehicles(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        VehicleAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    vehicles(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        VehicleAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    vehicles(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}

private func startships(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        StarshipAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                    
                }
                if !result.next.isEmpty {
                    startships(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        StarshipAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                    
                }
                if !result.next.isEmpty {
                    startships(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}
 
private func planets(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        PlanetAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                    
                }
                if !result.next.isEmpty {
                    planets(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        PlanetAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    planets(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}
 
private func peoples(url: String) {
    let imageApi = ImageAPIImpl()
    if url.isEmpty {
        PeopleAPIImpl().search(
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    peoples(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    } else {
        PeopleAPIImpl().page(
            url: url,
            completion: { result in
                result.results.forEach {
                    items.append(JsonImage(name: $0.name, image: imageApi.getUrlImage(name: $0.name)))
                }
                if !result.next.isEmpty {
                    peoples(url: result.next)
                } else {
                    printJson()
                }
            },
            failure: { _ in
            })
    }
}

private func printJson() {
    guard let result = try? JSONEncoder().encode(items) else {
        return
    }
    print(String(data: result, encoding: String.Encoding.utf8))
}

//films(url: String.Empty)
species(url: String.Empty)
//vehicles(url: String.Empty)
//startships(url: String.Empty)
//planets(url: String.Empty)
//peoples(url: String.Empty)
