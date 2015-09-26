struct Snack: SnackProtocol {
    var objectId: String?
    var snackName: String
    var snackDescription: String
    
    init(objectId: String, name: String, description: String) {
        self.objectId = objectId
        self.snackName = name
        self.snackDescription = description
    }
    
    init(snack obj: SnackProtocol) {
        self.init(name: obj.snackName, description: obj.snackDescription)
    }
}
