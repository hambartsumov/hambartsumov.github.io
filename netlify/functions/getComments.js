function hello() {
    return "Hello";
}


exports.handler = async function (event, context) {
    return hello();
};
