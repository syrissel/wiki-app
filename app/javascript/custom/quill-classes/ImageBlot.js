import Quill from 'quill';

const BlockEmbed = Quill.import('blots/block/embed');

class ImageBlot extends BlockEmbed {
    static create(url) {
        let node = super.create();
        node.setAttribute('class', 'quill_image_container');
        let imgNode = document.createElement('img');
        imgNode.setAttribute('src', url);
        node.appendChild(imgNode);

        return node;
    }

    // static value(domNode) {
    // 	return domNode.querySelector('img').getAttribute('src');
    // }

    static formats(node) {
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
ImageBlot.blotName = 'custom-image';
ImageBlot.tagName = 'div';
Quill.register(ImageBlot);
