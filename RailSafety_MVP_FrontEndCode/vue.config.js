// vue.config.js
module.exports = {
  lintOnSave: false,
  "transpileDependencies": [
    "vuetify-datetime-picker"
  ],
    devServer: {
    proxy: "http://localhost:8080",
    public: "http://localhost:8080",
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, content-type, Authorization, Accept'
    },
    watchOptions: {
      poll: true
     }
     
    },
    publicPath : process.env.NODE_ENV === 'production'
      ? '/Vuetify-md-pro-clone/'
      : '/'
}