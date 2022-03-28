const { environment } = require('@rails/webpacker')
const webpack = require("webpack");

const sass_url_loader = {
  test: /\.scss$/,
  use: [
    {
      loader: 'css-loader',
      options: {}
    }, {
      loader: 'resolve-url-loader',
      options: {}
    }, {
      loader: 'sass-loader',
      options: {
        sourceMap: true, // <-- !!IMPORTANT!!
      }
    }
  ]
}

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"] // for Bootstrap 4
  })
);

environment.loaders.append('sass', sass_url_loader)
module.exports = environment
