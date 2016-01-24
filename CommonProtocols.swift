/**
Contracts between client and backend.
Objects in this file are meant to be sent bidirectionally
*/
public
protocol SnackProtocol {
	var snackName: String { get set }
	var snackDescription: String { get set }
}

