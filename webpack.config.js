const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");

module.exports = {
  entry: {
    main: "./_src/js/index.js",
  },
  output: {
    filename: "./assets/template/js/[name].js",
    path: path.resolve(__dirname, "./"),
  },
  module: {
    rules: [
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: "asset/resource",
        generator: {
          filename: "./assets/template/fonts/[name][ext][query]",
        },
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: {
              url: false,
            },
          },
          "postcss-loader",
          // "group-css-media-queries-loader", Не правильно сортирует, надо бы сначала крупные размеры max-width
          "sass-loader",
        ],
      },
      {
        test: /\.css$/i,
        use: [MiniCssExtractPlugin.loader, "css-loader", "postcss-loader"],
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "./assets/template/css/[name].css",
    }),
  ],
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          compress: {
            drop_console: true,
          },
          mangle: true,
        },
      }),
    ],
  },

  devServer: {
    proxy: [
      {
        context: () => true,
        target: "https://stroymarket-osnova",
        changeOrigin: true,
        secure: false,
      },
    ],
    watchFiles: ["_src/**/*", "core/elements/**/*"],
    open: true,
    host: "stroymarket-osnova",
    port: 8085,
    hot: true,
    liveReload: true,
  },

  mode: "production",
  watchOptions: {
    ignored: /node_modules/,
  },
};
