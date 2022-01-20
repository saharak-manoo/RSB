/** @format */

import Choices from 'choices.js';

import './purecounter';
import './stock';

document.addEventListener('DOMContentLoaded', (event) => {
	load();
});

load = () => {
	var selectes = document.querySelectorAll('.search-select');
	selectes.forEach((e) => {
		new Choices(e, { shouldSort: false });
	});
};