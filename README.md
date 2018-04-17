# iTunesKit
Cliente que permite buscar en la iTunes Store. Es un framework desarrollado en Swift diseñado usando un enfoque Protocol Oriented Programming.

## Diseño
La programación orienta a Protocolos difiere de la orientada a Objetos en que en lugar de comenzar definiendo estructura de clases usamos protocolos, pero además, se fundamenta en tres pilares:

* *Herencia* de protocolos
* *Composición* de protocolos
* *Extensiones* de protocolos

![Framework Design](https://github.com/fitomad/ituneskit/blob/master/Images/pop_design.jpeg)

**Book**: Está formado por los protocolos `Track`, `Artwork` y `Sizing`

**Movie**: Formado por `Track`, `DVD`, `Artwork`, `Previewing` y `Timing`

**Song**: Está compuesta por `Track`, `Artwork`, `Previewing`, `Disc` y `Timing`

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
