const path = require('path')
const webpack = require('webpack')
const uglifyJsPlugin = require("babel-minify-webpack-plugin")
const ExtractTextPlugin = require('mini-css-extract-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');

module.exports = (env, args) => {
    const isProd = args.mode === 'production'

    let styleLoader = {
        loader: ExtractTextPlugin.loader,
        options: {
            hmr: !isProd
        }
    }

    return {
        entry: {
            // Файл "/assets/template/js/scripts.js" нельзя подключать через webpack, потому что он не будет реагировать на события плагинов MODX.
            // app: ['./_src/js/index.js', './_src/js/other/vendors.js', './_src/js/other/base.js'],
            main: './_src/js/index.js',
            module_filter_table: './_src/js/module_filter_table.js'
        },
        performance: {
            hints: false
        },
        module: {
            rules: [{
                    test: /\.(js)$/,
                    exclude: /node_modules/,
                    use: {
                        loader: 'babel-loader',
                        options: {
                            presets: ['@babel/preset-env']
                        }
                    }
                },
                {
                    test: /\.(sass)$/,
                    use: [
                        styleLoader,
                        'css-loader',
                        'postcss-loader',
                        {
                            loader: 'sass-loader',
                            options: {
                                sourceMap: true
                            }
                        }
                    ],
                },
                {
                    test: /\.(css)$/,
                    use: [
                        styleLoader,
                        'css-loader',
                    ]
                },
                // {
                //     test: /\.svg$/,
                //     use: [
                //         'url-loader'
                //     ]
                // },
                {
                    test: /\.(png|jpg|gif)$/,
                    use: [{
                        loader: 'file-loader',
                        options: {
                            name: 'tpl-imgs/[name].[ext]'
                        }
                    }]
                },
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    use: [{
                        loader: 'file-loader',
                        options: {
                            name: '[name].[ext]',
                            outputPath: 'fonts/'
                        }
                    }]
                }
            ]
        },
        plugins: [
            new uglifyJsPlugin(),
            new ExtractTextPlugin({
                filename: 'css/styles.css'
            }),
            new webpack.ProvidePlugin({
                $: "jquery",
                jQuery: "jquery",
            }),
            new webpack.HotModuleReplacementPlugin()
        ],

        optimization: {
            minimizer: [
                new OptimizeCSSAssetsPlugin({
                    cssProcessorPluginOptions: {
                        preset: ['default', { discardComments: { removeAll: true } }],
                    }
                })
            ],
        },

        resolve: {
            extensions: ['*', '.js']
        },
        output: {
            path: __dirname + '/assets/template/',
            publicPath: '/assets/template/',
            filename: 'js/[name].js'
        },
        devServer: {
            contentBase: './',
            publicPath: '/assets/template/',
            hot: true,
            open: true,
            proxy: {
                "/": {
                    target: "http://pilomat-pro.local/",
                    secure: false,
                    changeOrigin: true
                }
            }
        }
    }
}
