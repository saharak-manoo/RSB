/** @format */

import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
	connect() {
		console.log('Pagination -> ');
	}

	get(event) {
		let target = event.target;
    let url = target.dataset.url;

		if (url == undefined) {
			url = target.parentNode.dataset.url;
		}
		if (url) {
			get(url, {
				responseKind: 'turbo-stream',
			});
		}
	}
}
