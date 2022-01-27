/** @format */

import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
	static values = {
		stocksPath: String,
	};

	connect() {}

	sortBy(event) {
		let target = event.target;
		let icon = target.children[0];
		if (!icon) {
			target = target.parentNode;
			icon = target.children[0];
		}
		let order = '';

		if (icon.name === 'swap-vertical-outline') {
			icon.name = 'arrow-up-outline';
			icon.classList.add('text-primary');
			order = 'ASC';
		} else if (icon.name === 'arrow-up-outline') {
			icon.name = 'arrow-down-outline';
			icon.classList.add('text-primary');
			order = 'DESC';
		} else {
			icon.name = 'swap-vertical-outline';
			icon.classList.remove('text-primary');
			order = '';
		}

		let sortKey = target.dataset.sort;

		let params = new URLSearchParams();
		params.append('sort_key', sortKey);
		params.append('order', order);

		this.getData(params);
	}

	getData(params) {
		get(`${this.stocksPathValue}?${params}`, {
			responseKind: 'turbo-stream',
		});
	}
}
