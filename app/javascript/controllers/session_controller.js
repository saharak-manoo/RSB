/** @format */

import { Controller } from '@hotwired/stimulus';
import { FetchRequest, patch } from '@rails/request.js';

export default class extends Controller {
	static values = {
		destroyUserSessionPath: String,
	};

	connect() {
		console.log('load....');
	}

	async logout() {
		if (confirm('คุณต้องการออกจากระบบใช่หรือไม่?')) {
			let request = new FetchRequest(
				'delete',
				this.destroyUserSessionPathValue,
				{
					responseKind: 'json',
				}
			);

			let response = await request.perform();
			if (response.ok) window.location.reload();
		}
	}
}
