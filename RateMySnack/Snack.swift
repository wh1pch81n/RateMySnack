struct Snack: SnackWithRatingProtocol {
    var objectId: String?
    var snackName: String
    var snackDescription: String
	var snackRating: Int
    
	init(name: String, description: String, rating: Int) {
        self.snackName = name
        self.snackDescription = description
		self.snackRating = rating
    }
    
    init(snack obj: SnackWithRatingProtocol) {
		self.init(name: obj.snackName, description: obj.snackDescription, rating: obj.snackRating)
    }
}
