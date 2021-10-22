
import isCompatible from './utils/compatibility';
import config from './config';

document.addEventListener('DOMContentLoaded', () => {
    if (!isCompatible) {
        const errorMessage = config.get(
            'compatibility.errorMessage',
            'Unsupported browser!',
        );

        document.body.innerHTML = `<p>${errorMessage}</p>`;

        return;
    }

    document.documentElement.classList.remove('incompatible-browser');

    require('material-design-lite/material');
    require('./mdl-stepper');
    require('babel-polyfill');

    require('./components/initialize').initialize(document, true);

    // Focus first valid input control
    const focusables = document.querySelectorAll('.v-focusable');
    for (const element of Array.from(focusables)) {
        if (!(element.vComponent && typeof element.vComponent.focus === 'function')) {
            continue;
        }

        if (element.vComponent.focus()) {
            break;
        }
    }
});
