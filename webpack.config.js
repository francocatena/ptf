/* global module, process, require, __dirname */

const Path                  = require('path')
const CopyWebpackPlugin     = require('copy-webpack-plugin')
const HtmlWebpackPlugin     = require('html-webpack-plugin')
const FaviconsWebpackPlugin = require('favicons-webpack-plugin')
const MiniCssExtractPlugin  = require('mini-css-extract-plugin')
const isProduction          = process.env.npm_lifecycle_event === 'build'

const config = {
  mode: isProduction ? 'production' : 'development',

  entry: ['./js/app.js', './css/app.scss'],

  devtool: 'source-map',

  devServer: {
    open: true,
    port: 8000
  },

  output: {
    path:     Path.resolve(__dirname, 'dist'),
    filename: 'js/[name]-[contenthash].js'
  },

  module: {
    rules: [
      {
        test:    /\.js$/,
        loader:  'babel-loader',
        exclude: [
          /elm-stuff/,
          /node_modules/
        ]
      },

      {
        test:    /\.elm$/,
        exclude: [
          /elm-stuff/,
          /node_modules/
        ],
        use: [{
          loader: 'elm-webpack-loader',
          options: {
            cwd:      Path.resolve(__dirname, 'elm'),
            optimize: isProduction,
            verbose:  !isProduction,
            debug:    !isProduction
          }
        }]
      },

      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,

          {
            loader:  'css-loader',
            options: {
              sourceMap: !isProduction
            }
          },

          {
            loader:  'sass-loader',
            options: {
              sourceMap:      !isProduction,
              sourceComments: !isProduction,
              includePaths:   [
                Path.resolve(__dirname, 'node_modules/bulma')
              ]
            }
          }
        ]
      }
    ]
  },

  plugins: [
    new CopyWebpackPlugin([{from: 'static'}]),
    new MiniCssExtractPlugin({filename: 'css/[name]-[contenthash].css'}),
    new HtmlWebpackPlugin({
      title:    'Vintock',
      inject:   'body',
      template: 'index.html'
    }),
    new FaviconsWebpackPlugin({
      logo:   './images/favicon.png',
      prefix: 'icons/[hash]/',
      title:  'Vintock',
      icons:  {
        android:      true,
        appleIcon:    true,
        appleStartup: false,
        coast:        false,
        favicons:     true,
        firefox:      true,
        opengraph:    false,
        twitter:      false,
        yandex:       false,
        windows:      false
      }
    })
  ]
}

module.exports = config
