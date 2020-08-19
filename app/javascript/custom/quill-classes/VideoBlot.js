import Quill from 'quill';

// 
const BlockEmbed = Quill.import('blots/block/embed');

/**
 * Author: Steph Mireault
 * Date:   circa Winter 2019/2020
 * Description: 
 */

class VideoBlot extends BlockEmbed {
    static create(url) {
        let node = super.create();
        let thumbnail = $("input[name='video']:checked").data('thumbnail');
        node.setAttribute('src', url);
        // Set non-format related attributes with static values
        node.setAttribute('frameborder', '0');
        node.setAttribute('allowfullscreen', true);
        node.setAttribute('controls', 'controls');
        node.setAttribute('class', 'video-player');
        node.setAttribute('poster', thumbnail);

        return node;
    }

    static formats(node) {
        // We still need to report unregistered embed formats
        let format = {};
        if (node.hasAttribute('height')) {
            format.height = node.getAttribute('height');
        }
        if (node.hasAttribute('width')) {
            format.width = node.getAttribute('width');
        }
        return format;
    }

    static value(node) {
        return node.getAttribute('src');
    }

    format(name, value) {
        // Handle unregistered embed formats
        if (name === 'height' || name === 'width') {
            if (value) {
                this.domNode.setAttribute(name, value);
            } else {
                this.domNode.removeAttribute(name, value);
            }
        } else {
            super.format(name, value);
        }
    }
}
VideoBlot.blotName = 'db-video';
VideoBlot.tagName = 'video';
Quill.register(VideoBlot);