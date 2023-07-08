const jwt = require("jsonwebtoken");


function getJWTNow() {
    var private_key = fs.readFileSync('static/private.key');
    var payload = {
        iat: Date.now() / 1000 - 60,
        exp: Date.now() / 1000 + 10 * 60,
        iss: fs.readFileSync("static/appid.txt")
    };
}


function hello() {
    return "Hello";
}


exports.handler = async function (event, context) {
    return {
        statusCode: 200,
        body: JSON.stringify({ message: hello() }),
    }
};
