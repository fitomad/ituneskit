# iTunesKit
Cliente que permite buscar en la iTunes Store. Es un framework desarrollado en Swift diseñado usanfo un enfoque Protocol Oriented Programming.

## Diseño

## Ejemplos

Vamos a buscar un libro, concretamen Ready Player One.

```swift
iTunesClient.shared.book(named: "Ready Player One") { (result: iTunesResult<Book>) -> (Void) in
	switch result
	{
		case .success(let books):
			print("Se han encontrado \(books.count) libros.")

			for book in books
			{
				print("# \(book) Size: \(book.formattedFileSize)")
			}

		case .error(let message):
			print(message)

		case .empty:
			print("No se ha encontrado nada de nada...")
	}
}
```

Pero también podemos hacer una búsqueda general en la iTunes Store, por ejemlo, vamos a ver qué libros, canciones o películas no da el término **Jobs**

```swift
iTunesClient.shared.movie(named: "Jobs") { (result: iTunesResult<Track>) -> (Void) in
	switch result
	{
		case .success(let items):
			print("Se han encontrado \(items.count) productos.")

			print("Books...")
			for case let book as Book in items
			{
				print("\t- \(book.trackName) by \(book.artistName). Size: \(book.formattedFileSize)")
			}

			print("Songs...")
			for case let song as Song in items
			{
				print("\t- \(song.trackName) // \(song.collectionName). Duration: \(song.fomattedTrackTime)")
			}

			print("Movies...")
			for case let movie as Movie in items
			{
				print("\t- \(movie.trackName) by \(movie.collectionName). Duration: \(movie.fomattedTrackTime)")
			}

		case .error(let message):
			print(message)

		case .empty:
			print("No se ha encontrado nada de nada...")
	}
}
```

## Contacto

Para cualquier duda, sugerencia o comentario puedes contactar conmigo en twitter [@fitomad](https://twitter.com/fitomad)
