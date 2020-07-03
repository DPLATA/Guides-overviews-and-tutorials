let express = require('express');
let app = express();
let port = 8080;

app.get('/', (req, res) => {
    res.send('Hello Docker + Minikube tutorial! ;)')
});

app.listen(port, () => {console.log('app listening on port:', port)})
