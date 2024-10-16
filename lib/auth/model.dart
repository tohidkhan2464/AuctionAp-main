import 'dart:convert';

class Auction {
    List<Product> products;

    Auction({
        required this.products,
    });

    factory Auction.fromRawJson(String str) => Auction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Auction.fromJson(Map<String, dynamic> json) => Auction(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    String title;
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    Type type;
    Status status;
    bool downloadable;
    bool virtual;
    String permalink;
    String sku;
    String price;
    String regularPrice;
    dynamic salePrice;
    String priceHtml;
    bool taxable;
    TaxStatus taxStatus;
    String taxClass;
    bool managingStock;
    int? stockQuantity;
    bool inStock;
    bool backordersAllowed;
    bool backordered;
    bool soldIndividually;
    bool purchaseable;
    bool featured;
    bool visible;
    CatalogVisibility catalogVisibility;
    bool onSale;
    String productUrl;
    String buttonText;
    dynamic weight;
    Dimensions dimensions;
    bool shippingRequired;
    bool shippingTaxable;
    String shippingClass;
    dynamic shippingClassId;
    String description;
    ShortDescription shortDescription;
    bool reviewsAllowed;
    String averageRating;
    int ratingCount;
    List<int> relatedIds;
    List<dynamic> upsellIds;
    List<dynamic> crossSellIds;
    int parentId;
    List<Category> categories;
    List<dynamic> tags;
    List<Image> images;
    String featuredSrc;
    List<Attribute> attributes;
    List<dynamic> downloads;
    int downloadLimit;
    int downloadExpiry;
    DownloadType downloadType;
    String purchaseNote;
    int totalSales;
    List<dynamic> variations;
    List<dynamic> parent;
    List<dynamic> groupedProducts;
    int menuOrder;

    Product({
        required this.title,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.type,
        required this.status,
        required this.downloadable,
        required this.virtual,
        required this.permalink,
        required this.sku,
        required this.price,
        required this.regularPrice,
        required this.salePrice,
        required this.priceHtml,
        required this.taxable,
        required this.taxStatus,
        required this.taxClass,
        required this.managingStock,
        required this.stockQuantity,
        required this.inStock,
        required this.backordersAllowed,
        required this.backordered,
        required this.soldIndividually,
        required this.purchaseable,
        required this.featured,
        required this.visible,
        required this.catalogVisibility,
        required this.onSale,
        required this.productUrl,
        required this.buttonText,
        required this.weight,
        required this.dimensions,
        required this.shippingRequired,
        required this.shippingTaxable,
        required this.shippingClass,
        required this.shippingClassId,
        required this.description,
        required this.shortDescription,
        required this.reviewsAllowed,
        required this.averageRating,
        required this.ratingCount,
        required this.relatedIds,
        required this.upsellIds,
        required this.crossSellIds,
        required this.parentId,
        required this.categories,
        required this.tags,
        required this.images,
        required this.featuredSrc,
        required this.attributes,
        required this.downloads,
        required this.downloadLimit,
        required this.downloadExpiry,
        required this.downloadType,
        required this.purchaseNote,
        required this.totalSales,
        required this.variations,
        required this.parent,
        required this.groupedProducts,
        required this.menuOrder,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: typeValues.map[json["type"]]!,
        status: statusValues.map[json["status"]]!,
        downloadable: json["downloadable"],
        virtual: json["virtual"],
        permalink: json["permalink"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        priceHtml: json["price_html"],
        taxable: json["taxable"],
        taxStatus: taxStatusValues.map[json["tax_status"]]!,
        taxClass: json["tax_class"],
        managingStock: json["managing_stock"],
        stockQuantity: json["stock_quantity"],
        inStock: json["in_stock"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        soldIndividually: json["sold_individually"],
        purchaseable: json["purchaseable"],
        featured: json["featured"],
        visible: json["visible"],
        catalogVisibility: catalogVisibilityValues.map[json["catalog_visibility"]]!,
        onSale: json["on_sale"],
        productUrl: json["product_url"],
        buttonText: json["button_text"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        description: json["description"],
        shortDescription: shortDescriptionValues.map[json["short_description"]]!,
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
        upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"],
        categories: List<Category>.from(json["categories"].map((x) => categoryValues.map[x]!)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        featuredSrc: json["featured_src"],
        attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
        downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        downloadType: downloadTypeValues.map[json["download_type"]]!,
        purchaseNote: json["purchase_note"],
        totalSales: json["total_sales"],
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        parent: List<dynamic>.from(json["parent"].map((x) => x)),
        groupedProducts: List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": typeValues.reverse[type],
        "status": statusValues.reverse[status],
        "downloadable": downloadable,
        "virtual": virtual,
        "permalink": permalink,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "price_html": priceHtml,
        "taxable": taxable,
        "tax_status": taxStatusValues.reverse[taxStatus],
        "tax_class": taxClass,
        "managing_stock": managingStock,
        "stock_quantity": stockQuantity,
        "in_stock": inStock,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "sold_individually": soldIndividually,
        "purchaseable": purchaseable,
        "featured": featured,
        "visible": visible,
        "catalog_visibility": catalogVisibilityValues.reverse[catalogVisibility],
        "on_sale": onSale,
        "product_url": productUrl,
        "button_text": buttonText,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "description": description,
        "short_description": shortDescriptionValues.reverse[shortDescription],
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
        "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
        "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
        "parent_id": parentId,
        "categories": List<dynamic>.from(categories.map((x) => categoryValues.reverse[x])),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "featured_src": featuredSrc,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "downloads": List<dynamic>.from(downloads.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "download_type": downloadTypeValues.reverse[downloadType],
        "purchase_note": purchaseNote,
        "total_sales": totalSales,
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "parent": List<dynamic>.from(parent.map((x) => x)),
        "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
        "menu_order": menuOrder,
    };
}

class Attribute {
    Name name;
    Slug slug;
    int position;
    bool visible;
    bool variation;
    List<String> options;

    Attribute({
        required this.name,
        required this.slug,
        required this.position,
        required this.visible,
        required this.variation,
        required this.options,
    });

    factory Attribute.fromRawJson(String str) => Attribute.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: nameValues.map[json["name"]]!,
        slug: slugValues.map[json["slug"]]!,
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options.map((x) => x)),
    };
}

enum Name {
    DIGITS,
    PLATE_CODE
}

final nameValues = EnumValues({
    "Digits": Name.DIGITS,
    "Plate Code": Name.PLATE_CODE
});

enum Slug {
    DIGITS,
    PLATE_CODE
}

final slugValues = EnumValues({
    "digits": Slug.DIGITS,
    "plate-code": Slug.PLATE_CODE
});

enum CatalogVisibility {
    VISIBLE
}

final catalogVisibilityValues = EnumValues({
    "visible": CatalogVisibility.VISIBLE
});

enum Category {
    LICENSE_PLATE
}

final categoryValues = EnumValues({
    "License Plate": Category.LICENSE_PLATE
});

class Dimensions {
    String length;
    String width;
    String height;
    Unit unit;

    Dimensions({
        required this.length,
        required this.width,
        required this.height,
        required this.unit,
    });

    factory Dimensions.fromRawJson(String str) => Dimensions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
        unit: unitValues.map[json["unit"]]!,
    );

    Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
        "unit": unitValues.reverse[unit],
    };
}

enum Unit {
    CM
}

final unitValues = EnumValues({
    "cm": Unit.CM
});

enum DownloadType {
    STANDARD
}

final downloadTypeValues = EnumValues({
    "standard": DownloadType.STANDARD
});

class Image {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String src;
    String title;
    String alt;
    int position;

    Image({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.src,
        required this.title,
        required this.alt,
        required this.position,
    });

    factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        src: json["src"],
        title: json["title"],
        alt: json["alt"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "src": src,
        "title": title,
        "alt": alt,
        "position": position,
    };
}

enum ShortDescription {
    EMPTY,
    P_BOTH_P,
    P_EACH_P
}

final shortDescriptionValues = EnumValues({
    "": ShortDescription.EMPTY,
    "<p>both</p>\n": ShortDescription.P_BOTH_P,
    "<p>each</p>\n": ShortDescription.P_EACH_P
});

enum Status {
    PUBLISH
}

final statusValues = EnumValues({
    "publish": Status.PUBLISH
});

enum TaxStatus {
    TAXABLE
}

final taxStatusValues = EnumValues({
    "taxable": TaxStatus.TAXABLE
});

enum Type {
    AUCTION,
    SIMPLE
}

final typeValues = EnumValues({
    "auction": Type.AUCTION,
    "simple": Type.SIMPLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
