/** @format */

import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
	static values = {
		url: String,
		isFilterSelect: Boolean,
		isDatePicker: Boolean,
		isDatePickerBetween: Boolean
	};
	static targets = ["searchInput", "limitSelect", "filterSelect", "datepickerInput", "datepickerStartDateInput", "datepickerEndDateInput"]

	connect() {}

	defaultParams() {
		let params = new URLSearchParams();
		if (this.isFilterSelectValue) {
			if (this.filterSelectTarget) {
				params.append(
					this.filterSelectTarget.dataset.name,
					this.filterSelectTarget.value
				);
			}
		}
		if (this.isDatePickerValue) {
			if (this.datepickerInputTarget) {
				params.append(
					this.datepickerInputTarget.dataset.name,
					this.datepickerInputTarget.value
				);
			}
		}
		if (this.isDatePickerBetweenValue) {
			if (this.datepickerStartDateInputTarget) {
				params.append(
					this.datepickerStartDateInputTarget.dataset.name,
					this.datepickerStartDateInputTarget.value
				);
			}

			if (this.datepickerEndDateInputTarget) {
				params.append(
					this.datepickerEndDateInputTarget.dataset.name,
					this.datepickerEndDateInputTarget.value
				);
			}
		}
		params.append(
			this.limitSelectTarget.dataset.name || 'limit',
			this.limitSelectTarget.value
		);
		params.append(this.searchInputTarget.dataset.name || 'keyword', this.searchInputTarget.value);

		return params;
	}

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
			order = 'asc';
		} else if (icon.name === 'arrow-up-outline') {
			icon.name = 'arrow-down-outline';
			icon.classList.add('text-primary');
			order = 'desc';
		} else {
			icon.name = 'swap-vertical-outline';
			icon.classList.remove('text-primary');
			order = '';
		}

		let sortKey = target.dataset.sort;
		let params = this.defaultParams();
		params.append('sort_key', sortKey);
		params.append('order', order);

		this.getData(params);
	}

	search() {
		this.getData(this.defaultParams());
	}

	searchWithDatePicker() {
		this.getData(this.defaultParams());
	}

	getData(params) {
		get(`${this.urlValue}?${params}`, {
			responseKind: 'turbo-stream',
		});
	}
}
