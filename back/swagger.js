const swaggerAutogen = require('swagger-autogen')();

const doc = {
  info: {
    title: 'Swagger Mono Paul Hi !',
    description: 'Notre swagger de test'
  },
  components: {
    securitySchemes: {
        bearerAuth: {
            type: 'http',
            scheme: 'bearer',
            bearerFormat: 'JWT',
        }
    }
    },
  host: 'localhost:8000'
};

const outputFile = './swagger-output.json';
const routes = ['./routes.js'];

/* NOTE: If you are using the express Router, you must pass in the 'routes' only the 
root file where the route starts, such as index.js, app.js, routes.js, etc ... */

swaggerAutogen(outputFile, routes, doc);