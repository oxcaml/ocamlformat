type 'a r = {a: 'a @@ global; b: 'a @@ global portable}

type 'a r = Foo of 'a * 'a @@ global | Bar : 'a @@ global -> 'a r
