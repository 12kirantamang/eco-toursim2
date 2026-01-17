// Okayama Tourism Website - Main JavaScript

// Language translations
// const translations = {
//   en: {
//     siteTitle: "Discover Okayama",
//     heroTitle: "Experience the Beauty of Okayama",
//     heroSubtitle: "Where tradition meets modern charm in the Land of Sunshine",
//     exploreBtn: "Explore Attractions",
//     bookBtn: "Hotels",
//     aboutTitle: "About",
//     aboutText: "Okayama, known as the 'Land of Sunshine,' is home to the iconic Crow Castle and stunning Korakuen Garden. This historic city seamlessly blends traditional Japanese culture with modern amenities, offering visitors an authentic experience of Japan's rich heritage.",
//     attractionsTitle: "Attractions",
//     foodTitle: "Food",
//     eventsTitle: "Upcoming Events",
//     testimonialsTitle: "Traveler Reviews",
//     contactTitle: "Contact",
//     viewAll: "View All",
//     learnMore: "Learn More",
//     bookNow: "Book Now",
//     language: "Language"
//   },
//   ja: {
//     siteTitle: "岡山発見",
//     heroTitle: "岡山の美しさを体験",
//     heroSubtitle: "伝統と現代の魅力が出会う陽の国",
//     exploreBtn: "観光地を探索",
//     bookBtn: "ホテルを予約",
//     aboutTitle: "岡山について",
//     aboutText: "『陽の国』として知られる岡山は、烏城と後楽園のある歴史的な都市です。伝統的な日本文化と現代的な設備が調和し、訪問者に日本の豊かな遺産の本格的な体験を提供します。",
//     attractionsTitle: "必見の観光地",
//     foodTitle: "郷土料理",
//     eventsTitle: "今後のイベント",
//     testimonialsTitle: "旅行者のレビュー",
//     contactTitle: "お問い合わせ",
//     viewAll: "すべて見る",
//     learnMore: "詳しく見る",
//     bookNow: "今すぐ予約",
//     language: "言語"
//   },
  // ne: {
  //   siteTitle: "ओकायामा अन्वेषण",
  //   heroTitle: "ओकायामाको सौन्दर्य अनुभव गर्नुहोस्",
  //   heroSubtitle: "परम्परा र आधुनिक आकर्षण भेटिने सूर्यको देश",
  //   exploreBtn: "आकर्षणहरू अन्वेषण गर्नुहोस्",
  //   bookBtn: "होटल बुक गर्नुहोस्",
  //   aboutTitle: "ओकायामा बारेमा",
  //   aboutText: "'सूर्यको देश' को रूपमा चिनिने ओकायामा प्रसिद्ध क्रो क्यासल र सुन्दर कोराकुएन उद्यानको घर हो। यो ऐतिहासिक शहरले परम्परागत जापानी संस्कृति र आधुनिक सुविधाहरूलाई सहज रूपमा मिसाउँछ।",
  //   attractionsTitle: "अवश्य भेट्नुपर्ने आकर्षणहरू",
  //   foodTitle: "स्थानीय खाना",
  //   eventsTitle: "आगामी कार्यक्रमहरू",
  //   testimonialsTitle: "यात्रुहरूको समीक्षा",
  //   contactTitle: "सम्पर्क गर्नुहोस्",
  //   viewAll: "सबै हेर्नुहोस्",
  //   learnMore: "थप जान्नुहोस्",
  //   bookNow: "अहिले बुक गर्नुहोस्",
  //   language: "भाषा"
  // },
  // my: {
  //   siteTitle: "အိုကာယာမားရှာဖွေမှု",
  //   heroTitle: "အိုကာယာမားလှပမှုကိုခံစားပါ",
  //   heroSubtitle: "ရိုးရာအမူအရာများနှင့်အတူ ခေတ်မီဆွဲဆောင်မှုတွေ့ဆုံရာနေရာ",
  //   exploreBtn: "စိတ်ဝင်စားဖွယ်အရာများရှာဖွေပါ",
  //   bookBtn: "ဟိုတယ်များမှာယူပါ",
  //   aboutTitle: "အိုကာယာမားအကြောင်း",
  //   aboutText: "'နေရောင်ခြည်နိုင်ငံဟု'အမည်ရအိုကာယာမားသည် နာမည်ကြီးအနက်ရောင်ခံတပ်နှင့် လှပသောကိုရာကူအင်ဥယျာဉ်ရှိသည်။ ဤသမိုင်းဝင်မြို့တွင်ရိုးရာဂျပန်ယဉ်ကျေးမှုနှင့် ခေတ်မီအဆောက်အအုံများကိုပေါင်းစပ်ထားသည်။",
  //   attractionsTitle: "လည်ပတ်ကြည့်ရှုသင့်သောနေရာများ",
  //   foodTitle: "ဒေသဆိုင်ရာအစားအစာ",
  //   eventsTitle: "လာမည့်အစီအစဉ်များ",
  //   testimonialsTitle: "ခရီးသည်များအချုပ်ချုပ်",
  //   contactTitle: "ဆက်သွယ်ပါ",
  //   viewAll: "အားလုံးကြည့်ပါ",
  //   learnMore: "ပိုမိုလေ့လာပါ",
  //   bookNow: "ယခုမှာယူပါ",
  //   language: "ဘာသာစကား"
  // },
  // vi: {
  //   siteTitle: "Khám Phá Okayama",
  //   heroTitle: "Trải Nghiệm Vẻ Đẹp Okayama",
  //   heroSubtitle: "Nơi truyền thống gặp gỡ sức hút hiện đại trong Vùng Đất Củ Nắng",
  //   exploreBtn: "Khám Phá Điểm Tham Quan",
  //   bookBtn: "Đặt Khách Sạn",
  //   aboutTitle: "Về Okayama",
  //   aboutText: "Okayama, được biết đến là 'Vùng Đất Củ Nắng,' là nơi có Lâu Đài Quạ biểu tượng và Vườn Korakuen tuyệt đẹp. Thành phố lịch sử này kết hợp hoàn hảo văn hóa truyền thống Nhật Bản với tiện nghi hiện đại.",
  //   attractionsTitle: "Điểm Tham Quan Không Thể Bỏ Qua",
  //   foodTitle: "Ẩm Thực Địa Phương",
  //   eventsTitle: "Sự Kiện Sắp Tới",
  //   testimonialsTitle: "Đánh Giá Củ Du Khách",
  //   contactTitle: "Liên Hệ",
  //   viewAll: "Xem Tất Cả",
  //   learnMore: "Tìm Hiểu Thêm",
  //   bookNow: "Đặt Ngay",
  //   language: "Ngôn Ngữ"
  // }
// };

// Current language
let currentLang = 'en';

// DOM Elements
const languageOptions = document.querySelectorAll('.language-option');
const translatableElements = document.querySelectorAll('[data-translate]');

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
  initializeLanguage();
  initializeScrollAnimations();
  initializeNavigation();
  initializeHeroEffects();
  
  // Set initial language from URL parameter if available
  const urlParams = new URLSearchParams(window.location.search);
  const langParam = urlParams.get('lang');
  if (langParam && translations[langParam]) {
    currentLang = langParam;
    updateLanguage();
  }
});

// Language functionality
function initializeLanguage() {
  languageOptions.forEach(option => {
    option.addEventListener('click', function() {
      const lang = this.dataset.lang;
      if (translations[lang]) {
        currentLang = lang;
        updateLanguage();
        updateURLParameter(lang);
      }
    });
  });
}

function updateLanguage() {
  translatableElements.forEach(element => {
    const key = element.dataset.translate;
    if (translations[currentLang] && translations[currentLang][key]) {
      if (element.tagName === 'INPUT' && element.type === 'placeholder') {
        element.placeholder = translations[currentLang][key];
      } else {
        element.textContent = translations[currentLang][key];
      }
    }
  });
  
  // Update document title
  document.title = translations[currentLang].siteTitle;
  
  // Update language selector display
  const currentFlag = document.querySelector('.current-flag');
  const currentLangText = document.querySelector('.current-lang');
  if (currentFlag && currentLangText) {
    currentFlag.src = `resources/icons/flag-${currentLang}.png`;
    currentLangText.textContent = getLanguageName(currentLang);
  }
}

function updateURLParameter(lang) {
  const url = new URL(window.location);
  url.searchParams.set('lang', lang);
  window.history.replaceState({}, '', url);
}

function getLanguageName(langCode) {
  const names = {
    en: 'English',
    ja: '日本語',
    ne: 'नेपाली',
    my: 'မြန်မာ',
    vi: 'Tiếng Việt'
  };
  return names[langCode] || langCode;
}

// Scroll animations
function initializeScrollAnimations() {
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };
  
  const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, observerOptions);
  
  document.querySelectorAll('.fade-in-up').forEach(el => {
    observer.observe(el);
  });
}

// Navigation functionality
function initializeNavigation() {
  const navbar = document.querySelector('.navbar');
  const navLinks = document.querySelectorAll('.nav-links a');
  
  // Navbar scroll effect
  window.addEventListener('scroll', function() {
    if (window.scrollY > 50) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  });
  
  // Smooth scrolling for anchor links
  navLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      const href = this.getAttribute('href');
      if (href.startsWith('#')) {
        e.preventDefault();
        const target = document.querySelector(href);
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      }
    });
  });
}

// Hero section effects
function initializeHeroEffects() {
  const heroTitle = document.querySelector('.hero-title');
  const heroSubtitle = document.querySelector('.hero-subtitle');
  const heroButtons = document.querySelector('.hero-buttons');
  
  // Animate hero elements on load
  if (heroTitle) {
    heroTitle.style.opacity = '0';
    heroTitle.style.transform = 'translateY(30px)';
    
    setTimeout(() => {
      heroTitle.style.transition = 'all 1s ease-out';
      heroTitle.style.opacity = '1';
      heroTitle.style.transform = 'translateY(0)';
    }, 500);
  }
  
  if (heroSubtitle) {
    heroSubtitle.style.opacity = '0';
    heroSubtitle.style.transform = 'translateY(30px)';
    
    setTimeout(() => {
      heroSubtitle.style.transition = 'all 1s ease-out';
      heroSubtitle.style.opacity = '1';
      heroSubtitle.style.transform = 'translateY(0)';
    }, 800);
  }
  
  if (heroButtons) {
    heroButtons.style.opacity = '0';
    heroButtons.style.transform = 'translateY(30px)';
    
    setTimeout(() => {
      heroButtons.style.transition = 'all 1s ease-out';
      heroButtons.style.opacity = '1';
      heroButtons.style.transform = 'translateY(0)';
    }, 1100);
  }
}

// Utility functions
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

function throttle(func, limit) {
  let inThrottle;
  return function() {
    const args = arguments;
    const context = this;
    if (!inThrottle) {
      func.apply(context, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  }
}

// Form validation utilities
function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

function validatePhone(phone) {
  const re = /^[\+]?[1-9][\d]{0,15}$/;
  return re.test(phone.replace(/\s/g, ''));
}

// Local storage utilities
function saveToLocalStorage(key, data) {
  try {
    localStorage.setItem(key, JSON.stringify(data));
  } catch (e) {
    console.warn('Could not save to localStorage:', e);
  }
}

function getFromLocalStorage(key) {
  try {
    const item = localStorage.getItem(key);
    return item ? JSON.parse(item) : null;
  } catch (e) {
    console.warn('Could not read from localStorage:', e);
    return null;
  }
}

// Analytics and tracking (placeholder)
function trackEvent(category, action, label = '') {
  // Placeholder for analytics tracking
  console.log('Event tracked:', { category, action, label });
}

// Error handling
window.addEventListener('error', function(e) {
  console.error('JavaScript error:', e.error);
  // Could send to error tracking service
});

// Performance monitoring
window.addEventListener('load', function() {
  // Log page load performance
  const perfData = performance.getEntriesByType('navigation')[0];
  console.log('Page load time:', perfData.loadEventEnd - perfData.loadEventStart);
});
  // Initialize Splide carousel for events
        document.addEventListener('DOMContentLoaded', function() {
            if (document.getElementById('events-carousel')) {
                new Splide('#events-carousel', {
                    type: 'loop',
                    perPage: 3,
                    perMove: 1,
                    gap: '2rem',
                    autoplay: true,
                    interval: 5000,
                    pauseOnHover: true,
                    breakpoints: {
                        768: {
                            perPage: 1,
                        },
                        1024: {
                            perPage: 2,
                        }
                    }
                }).mount();
            }
        });
