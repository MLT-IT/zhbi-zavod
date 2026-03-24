<?php

/**
 * Возвращает fallback-баннеры для листинга каталога.
 *
 * @param int $id ID текущего ресурса
 * @return array
 */

$resourceId = (int)($scriptProperties['id'] ?? 0);

$universalSlugs = [
  'accessories-promo',
  'measurer-promo',
];

$resourceSpecificSlugs = [
  73553 => [
    'grandline-monterrey-promo',
    'matte-metal-profile-promo',
    'valley-ridge-trim-promo',
  ],
  89532 => [
    'proflist-c8-promo',
    'profile-pipes-promo',
    'mp20-promo',
  ],
  89533 => [
    'proflist-c8-promo',
    'profile-pipes-promo',
  ],
  92853 => [
    'mp20-promo',
  ],
  75952 => [
    'ondulin-promo',
  ],
  97031 => [
    'docke-soffit-promo',
  ],
];

$slugs = array_values(array_unique(array_merge(
  $resourceSpecificSlugs[$resourceId] ?? [],
  $universalSlugs
)));

$buildButtonStyles = static function (string $bottom): array {
  return [
    'left' => '50%',
    'bottom' => $bottom,
    'transform' => 'translateX(-50%)',
    'z-index' => '2',
  ];
};

$buildBannerGroup = static function (string $slug) use ($buildButtonStyles): array {
  return [
    'data' => [
      'button-classname' => 'btn_style_base',
    ],
    'button' => [
      'desktop' => [],
      'tablet' => [],
      'mobile' => [],
    ],
    'banners_by_type' => [
      'desktop' => [
        'image_url' => "/assets/template/img/for-listing/{$slug}-desktop.svg",
        'data' => [
          'button-hidden' => 0,
        ],
        'button' => $buildButtonStyles('24px'),
      ],
      'tablet' => [
        'image_url' => "/assets/template/img/for-listing/{$slug}-tablet.svg",
        'data' => [
          'button-hidden' => 0,
        ],
        'button' => $buildButtonStyles('20px'),
      ],
      'mobile' => [
        'image_url' => "/assets/template/img/for-listing/{$slug}-mobile.svg",
        'data' => [
          'button-hidden' => 0,
        ],
        'button' => $buildButtonStyles('16px'),
      ],
    ],
  ];
};

$fallbackBannerGroups = [];
foreach ($slugs as $slug) {
  $fallbackBannerGroups[] = $buildBannerGroup($slug);
}

return $fallbackBannerGroups;
