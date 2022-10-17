export default function init() {
    var youtube_player = {
        init: function () {
            let videos = document.querySelectorAll('.lazy-video');

            for (let i = 0; i < videos.length; i++) {
                this.setupVideo(videos[i]);
            }
        },

        setupVideo: function (video) {
            let link = video.querySelector('.lazy-video__link');
            let media = video.querySelector('.lazy-video__media');
            let button = video.querySelector('.lazy-video__button');
            let id = this.parseMediaURL(media);
            let t = this;

            video.addEventListener('click', function () {
                let iframe = t.createIframe(id);

                $(link).remove();
                $(button).remove();
                video.appendChild(iframe);
            });

            link.removeAttribute('href');
            video.classList.add('video-enabled');
        },

        parseMediaURL: function (media) {
            let regexp = /https:\/\/i\.ytimg\.com\/vi\/([a-zA-Z0-9_-]+)\/maxresdefault\.jpg/i;
            let url = media.getAttribute('data-src');
            let match = url.match(regexp);

            return match[1];
        },

        createIframe: function (id) {
            let iframe = document.createElement('iframe');

            iframe.setAttribute('allowfullscreen', '');
            iframe.setAttribute('src', this.generateURL(id));
            iframe.classList.add('lazy-video__media');

            return iframe;
        },

        generateURL: function (id) {
            let query = '?rel=0&showinfo=0&autoplay=1';

            return 'https://www.youtube.com/embed/' + id + query;
        }
    };

    youtube_player.init();
}
