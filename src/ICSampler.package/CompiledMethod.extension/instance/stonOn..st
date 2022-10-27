*ICSampler
stonOn: stonWriter

	stonWriter writeObject: self streamMap: [ :dictionary | 
		dictionary
			at: #owner put: self methodClass instanceSide name;
			at: #isMeta put: self methodClass isMeta;
			at: #selector put: self selector ]