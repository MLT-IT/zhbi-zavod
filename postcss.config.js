module.exports = ({ file, options, env }) => ({
    parser: false,
    plugins: {
        'postcss-import': {},
        'postcss-cssnext': {
            features: {
                customProperties: false
            }
        },
        'postcss-sort-media-queries' : {},
        'cssnano':  env === 'production'  ? {} : false
    }
});