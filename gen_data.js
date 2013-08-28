var demo = db.getSiblingDB('demo');

function randomName()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    var nameLen = Math.floor((Math.random()*20) + 5)
    for ( var i=0; i < nameLen; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}

function randomPhone()
{
    var text = "";
    var possible = "0123456789";

    for ( var i=0; i < 10; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return parseInt(text);
}

function randomCount()
{
	// random 5 to 500
	return Math.floor((Math.random()*100)+1) * 5;
}

while ( true ) {
	doc = {
		"_id" : randomPhone(),
		"n" : randomName(),
		"b" : []
	}
	for ( var i=0; i < randomCount(); i++ ) {
		contact = {
			"n" : randomName(),
			"p" : randomPhone()
		}
		doc.b[i] = contact;
	}

	demo.users.insert(doc);
}