/** @format */

import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
	connect() {
		console.log('load -> ');
	}

	get(event) {
		let target = event.target;

		console.log('url -> ', target.dataset.url);
		get(target.dataset.url, {
			responseKind: 'turbo-stream',
		});
	}
}
