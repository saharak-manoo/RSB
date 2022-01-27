/** @format */

import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
	connect() {
		console.log('Pagination -> ');
	}

	search(event) {
		let target = event.target;
		let params = new URLSearchParams();
		params.append('keyword', target.value);

		get(`${target.dataset.url}?${params}`, {
			responseKind: 'turbo-stream',
		});
	}
}
