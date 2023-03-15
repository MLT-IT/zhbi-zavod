const fs = require('fs')
const path = require('path')
const webpack = require('webpack')
const uglifyJsPlugin = require("babel-minify-webpack-plugin")
const ExtractTextPlugin = require('mini-css-extract-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')

const miniCss = require('mini-css-extract-plugin')
const CopyPlugin = require('copy-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
// Нужен для обновления pug на devServer
const HtmlWebpackHarddiskPlugin = require('html-webpack-harddisk-plugin')

module.exports = (env, args) => {
    const isProd = args.mode === 'production'

    const PAGES_DIR = path.resolve(__dirname, '_src/views/')
    const PAGES = fs.readdirSync(PAGES_DIR).filter(fileName => fileName.endsWith('.pug'))

    let styleLoader = {
        loader: ExtractTextPlugin.loader,
        options: {
            hmr: !isProd,
        }
    }

    return {
        entry: {
            main: ['./_src/js/index.js'],
            // preloader: ['./_src/js/preloader.js'],
            // module_filter_table: './_src/js/module_filter_table.js'
        },
        output: {
            path: path.resolve(__dirname, 'assets/template/'),
            publicPath: '/assets/template/',
            filename: 'js/[name].js'
        },
        performance: {
            hints: false
        },
        module: {
            rules: [
                {
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
                    test: /\.pug/,
                    use: {
                        loader: "pug-loader",
                        options: {
                            pretty: true
                        }
                    }
                },
                {
                    test: /\.(sass)$/,
                    use: [
                        isProd ? miniCss.loader : styleLoader.loader,
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
                        styleLoader.loader,
                        'css-loader',
                    ]
                },
                {
                    test: /\.(png|jpg|gif|svg)$/,
                    exclude: /fonts/,
                    use: [{
                        loader: 'file-loader',
                        options: {
                            name: '[name].[ext]'
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
            new webpack.HotModuleReplacementPlugin(),
            new uglifyJsPlugin(),
            new miniCss({
                filename: 'css/[name].css',
            }),
            new webpack.ProvidePlugin({
                $: "jquery",
                jQuery: "jquery",
            }),
            new CopyPlugin({
                patterns: [
                    {
                        from: "_src/img",
                        globOptions: {
                            ignore: ['**/svg-sprite']
                        }
                    },
                ],
            }),
            ...PAGES.map(page => new HtmlWebpackPlugin({
                template: `${PAGES_DIR}/${page}`,
                filename: `../../${page.replace(/\.pug/,'.html')}`,
                inject: false,
                alwaysWriteToDisk: true,
                minify: {
                    collapseWhitespace: false,
                    removeComments: true,
                    removeRedundantAttributes: true,
                    useShortDoctype: true,
                },
            })),
            new HtmlWebpackHarddiskPlugin()
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

        devServer: {
            contentBase: './',
            publicPath: './assets/template/',
            writeToDisk: (filePath) => {
                return /main\.css$/.test(filePath) || /main\.js$/.test(filePath);
            },
            hot: true,
            open: true,
            proxy: {
                "/": {
                    target: 'http://monolit-main.local/',
                    secure: false,
                    changeOrigin: true
                }
            }
        }
    }
}
