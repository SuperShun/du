
const CookieUtil = {
    set(value) {
        const domain = '.' + window.location.host.split('.').slice(-2).join('.');
        document.cookie = `tgName=${value}; path=/; domain=${domain}`;
    },

    get() {
        const match = document.cookie.match('(^|;)\\s*tgName\\s*=\\s*([^;]+)');
        return match ? match.pop() : null;
    }
};


const URLHandler = {

    getTgName() {
        const search = window.location.search;
        if (search && search.startsWith('?')) {
            const tgName = search.substring(1);
            CookieUtil.set(tgName);
            return tgName;
        }
        return CookieUtil.get();
    },


    normalizeUrl(url) {
        const tgName = this.getTgName();
        if (!tgName) return url;

        try {
            let baseUrl = url;
            let hash = '';
            
            const hashIndex = url.indexOf('#');
            if (hashIndex !== -1) {
                baseUrl = url.substring(0, hashIndex);
                hash = url.substring(hashIndex);
            }

            baseUrl = baseUrl.split('?')[0];
            return `${baseUrl}?${tgName}${hash}`;
        } catch (e) {
            console.error('URL处理错误:', e);
            return url;
        }
    },

    handleLinks() {
        const tgName = this.getTgName();
        if (!tgName) return;

        document.querySelectorAll('a').forEach(link => {
            const href = link.getAttribute('href');
            if (href && !href.startsWith('javascript:') && href !== '#') {
                if (href.startsWith('http') && !href.includes(window.location.hostname)) {
                    return; 
                }
                link.href = this.normalizeUrl(href);
            }
        });
    },

    handleForms() {
        const tgName = this.getTgName();
        if (!tgName) return;

        document.querySelectorAll('form').forEach(form => {
            const originalSubmit = form.onsubmit;
            form.onsubmit = function(e) {
                if (originalSubmit && !originalSubmit.call(this, e)) {
                    return false;
                }

                const action = form.getAttribute('action') || window.location.href;
                form.action = URLHandler.normalizeUrl(action);
                return true;
            };
        });
    }
};

(function checkBeforeLoad() {
    const search = window.location.search;
    if (search && search.startsWith('?')) {
        const tgName = search.substring(1);
        CookieUtil.set(tgName);
    } else {
        const savedTgName = CookieUtil.get();
        if (savedTgName) {
            const currentUrl = window.location.href;
            const newUrl = URLHandler.normalizeUrl(currentUrl);
            if (newUrl !== currentUrl) {
                window.location.replace(newUrl);
            }
        }
    }
})();


function setupObserver() {
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length) {
                URLHandler.handleLinks();
            }
        });
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
}

window.addEventListener('popstate', function() {
    const savedTgName = CookieUtil.get();
    if (savedTgName && !window.location.search) {
        const newUrl = URLHandler.normalizeUrl(window.location.href);
        if (newUrl !== window.location.href) {
            window.location.replace(newUrl);
        }
    }
});

document.addEventListener('DOMContentLoaded', function() {
    URLHandler.handleLinks();
    URLHandler.handleForms();
    setupObserver();
});

window.CookieUtil = CookieUtil;
window.URLHandler = URLHandler;