#let altceva = state("altceva", none)

#let caca(ceva: none) = {
	altceva.update(ceva)
}

#locate(loc => {
	altceva.at(loc)
})

#caca(ceva: "da")

#locate(loc => {
	altceva.at(loc)
})

#caca(ceva: "nedaud")

#locate(loc => {
	altceva.at(loc)
})

#let zum() = {
	locate(loc => {
		assert(altceva.at(loc) == "da", message: "nu e da ma")
	})
}

#zum()
