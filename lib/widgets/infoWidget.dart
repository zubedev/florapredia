// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';

// CLASS: INFOWIDGET
class InfoWidget extends StatelessWidget{
  // properties
  final String floraClass;

  // constructor
  InfoWidget({@required this.floraClass});

  @override
  Widget build(BuildContext context) {
    // properties
    Map<String, String> floraMap = {}; // wiki

    switch(floraClass) {
      case 'Allamanda': {floraMap = _allamanda();} break;
      case 'Bachelors Button': {floraMap = _bachelorsButton();} break;
      case 'Begonia': {floraMap = _begonia();} break;
      case 'Bird of Paradise': {floraMap = _birdofParadise();} break;
      case 'Bougainvillea': {floraMap = _bougainvillea();} break;
      case 'Chrysanthemum': {floraMap = _chrysanthemum();} break;
      case 'Frangipani': {floraMap = _frangipani();} break;
      case 'Fuchsia': {floraMap = _fuchsia();} break;
      case 'Heliconia': {floraMap = _heliconia();} break;
      case 'Hibiscus': {floraMap = _hibiscus();} break;
      case 'Ixora': {floraMap = _ixora();} break;
      case 'Lantana': {floraMap = _lantana();} break;
      case 'Pagoda Flower': {floraMap = _pagoda();} break;
      case 'Pitcher Plant': {floraMap = _pitcher();} break;
      case 'Rafflesia': {floraMap = _rafflesia();} break;
      case 'Rhododendron': {floraMap = _rhododendron();} break;
    } // switch case

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Text('${floraMap['title']} Wiki', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),),
          Text('source: Wikipedia.org --- the free encycopledia', textScaleFactor: 0.5, style: TextStyle(color: Theme.of(context).accentColor),),
          SizedBox(height: 10.0,),
          Row(children: <Widget>[Text('Genus: '),Text(floraMap['genus'])],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          Row(children: <Widget>[Text('Kingdom: '),Text(floraMap['kingdom'])],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          Row(children: <Widget>[Text('Order: '),Text(floraMap['order'])],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          Row(children: <Widget>[Text('Family: '),Text(floraMap['family'])],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          Row(children: <Widget>[Text('Names: '),Text(floraMap['names'])],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          SizedBox(height: 10.0,),
          Text(floraMap['intro'],textAlign: TextAlign.justify,),
          SizedBox(height: 10.0,),
          Text(floraMap['description'],textAlign: TextAlign.justify,),
        ], // children <Widget>
      ), // Column()
    ); // return: Container()
  } // Widget: build()

  Map<String, String> _allamanda() {
    final Map<String, String> allamanda = {
      'title': 'Allamanda',
      'genus': 'Allamanda',
      'kingdom': 'Plantae',
      'order': 'Gentianales',
      'family': 'Apocynaceae',
      'names': 'Golden Trumpet, Trumpetvine, Yellow Allamanda',
      'intro': 'Allamanda is a genus of flowering plants in the dogbane '
          'family, Apocynaceae. They are native to the Americas, where they are '
          'distributed from Argentina. Some species are familiar as ornamental '
          'plants cultivated for their large, colorful flowers. Most species '
          'produce yellow flowers; A. blanchetii bears pink. The genus name '
          'Allamanda honors the Swiss botanist and physician Frédéric-Louis '
          'Allamand (1736–1809). It also is official flower of Kuching North City Hall.',
      'description': 'Plants of the genus are evergreen trees, shrubs, or vines. '
          'They contain a white latex. The leaves are opposite or arranged in whorls '
          'of up to 5. The blades are generally oval and smooth-edged, and some are '
          'leathery or lightly hairy. The inflorescence is a compound cyme. The '
          'flower has five lobed sepals and a bell- or funnel-shaped corolla of '
          'five petals, yellow in most species. The fruit is a schizocarp containing '
          'two to four seeds.',
    };
    return allamanda;
  } // _allamanda()

  Map<String, String> _bachelorsButton() {
    final Map<String, String> bachelorsButton = {
      'title': 'Centaurea',
      'genus': 'Centaurea',
      'kingdom': 'Plantae',
      'order': 'Asterales',
      'family': 'Asteraceae',
      'names': 'Bachelors Button, Cornflower',
      'intro': 'Centaurea cyanus, commonly known as cornflower or bachelors '
          'button, is an annual flowering plant in the family Asteraceae, native '
          'to Europe. In the past it often grew as a weed in cornfields (in the '
          'broad sense of "corn", referring to grains, such as wheat, barley, '
          'rye, or oats), hence its name. It is now endangered in its native habitat '
          'by agricultural intensification, particularly over-use of herbicides, '
          'destroying its habitat. It is also, however, through introduction as '
          'an ornamental plant in gardens and a seed contaminant in crop seeds, '
          'now naturalised in many other parts of the world, including North America '
          'and parts of Australia.',
      'description': 'Cornflower is an annual plant growing to 40–90 cm tall, '
          'with grey-green branched stems. The leaves are lanceolate, 1–4 cm long. '
          'The flowers are most commonly an intense blue colour, produced in flowerheads '
          '(capitula) 1.5–3 cm diameter, with a ring of a few large, spreading ray '
          'florets surrounding a central cluster of disc florets. The blue pigment '
          'is protocyanin, which in roses is red. It flowers all summer.',
    };
    return bachelorsButton;
  } // _bachelorsButton()

  Map<String, String> _begonia() {
    final Map<String, String> begonia = {
      'title': 'Begonia',
      'genus': 'Begonia',
      'kingdom': 'Plantae',
      'order': 'Cucurbitales',
      'family': 'Begoniaceae',
      'names': 'Begonia',
      'intro': 'Begonia is a genus of perennial flowering plants in the family '
          'Begoniaceae. The genus contains more than 1,800 different plant species. '
          'The Begonias are native to moist subtropical and tropical climates. '
          'Some species are commonly grown indoors as ornamental houseplants in '
          'cooler climates. In cooler climates some species are cultivated outside '
          'in summertime for their bright colourful flowers, which have sepals but no petals.',
      'description': 'With 1,831 species, Begonia is one of the largest genera of '
          'flowering plants. The species are terrestrial (sometimes epiphytic) '
          'herbs or undershrubs, and occur in subtropical and tropical moist climates, '
          'in South and Central America, Africa, and southern Asia. Terrestrial '
          'species in the wild are commonly upright-stemmed, rhizomatous, or tuberous. '
          'The plants are monoecious, with unisexual male and female flowers occurring '
          'separately on the same plant; the male contains numerous stamens, and '
          'the female has a large inferior ovary and two to four branched or twisted '
          'stigmas. In most species, the fruit is a winged capsule containing '
          'numerous minute seeds, although baccate fruits are also known. The leaves, '
          'which are often large and variously marked or variegated, are usually '
          'asymmetric (unequal-sided).',
    };
    return begonia;
  } // _begonia()

  Map<String, String> _birdofParadise() {
    final Map<String, String> birdofparadise = {
      'title': 'Strelitzia',
      'genus': 'Strelitzia',
      'kingdom': 'Plantae',
      'order': 'Zingiberales',
      'family': 'Strelitziaceae',
      'names': 'Bird of Paradise, Crane Flower',
      'intro': 'Strelitzia is a genus of five species of perennial plants, native '
          'to South Africa. It belongs to the plant family Strelitziaceae. The '
          'genus is named after the duchy of Mecklenburg-Strelitz, birthplace of '
          'Queen Charlotte of the United Kingdom. A common name of the genus is '
          'bird of paradise flower / plant, because of a resemblance of its flowers '
          'to birds-of-paradise. In South Africa it is commonly known as a crane '
          'flower and is featured on the reverse of the 50 cent coin. It is the '
          'floral emblem of the City of Los Angeles; two of the species, Strelitzia '
          'nicolai and Strelitzia reginae, are frequently grown as house plants.',
      'description': 'The species S. nicolai is the largest in the genus, reaching '
          '10 m tall, with stately white and blue flowers; the other species typically '
          'reach 2 to 3.5 m tall, except S. caudata which is a tree of a typically '
          'smaller size than S. nicolai. The leaves are large, 30–200 cm long and '
          '10–80 cm broad, similar to a banana leaf in appearance but with a longer '
          'petiole, and arranged strictly in two ranks to form a fan-like crown '
          'of evergreen foliage. The flowers are produced in a horizontal inflorescence '
          'emerging from a stout spathe.',
    };
    return birdofparadise;
  } // _birdofParadise()

  Map<String, String> _bougainvillea() {
    final Map<String, String> bougainvillea = {
      'title': 'Bougainvillea',
      'genus': 'Bougainvillea',
      'kingdom': 'Plantae',
      'order': 'Caryophyllales',
      'family': 'Nyctaginaceae',
      'names': 'Pokok Bunga Kertas',
      'intro': 'Bougainvillea is a genus of thorny ornamental vines, bushes, or '
          'trees. The inflorescence consists of large colourful sepallike bracts '
          'which surround three simple waxy flowers. It is native to South America '
          'from Brazil west to Peru and south to southern Argentina. Different '
          'authors accept between four and 18 species in the genus.',
      'description': 'The vine species grow anywhere from 1 to 12 m (3 to 40 ft.) '
          'tall, scrambling over other plants with their spiky thorns. The thorns '
          'are tipped with a black, waxy substance. They are evergreen where rainfall '
          'occurs all year, or deciduous if there is a dry season. The leaves are '
          'alternate, simple ovate-acuminate, 4–13 cm long and 2–6 cm broad. The '
          'actual flower of the plant is small and generally white, but each cluster '
          'of three flowers is surrounded by three or six bracts with the bright '
          'colours associated with the plant, including pink, magenta, purple, red, '
          'orange, white, or yellow. Bougainvillea glabra is sometimes referred '
          'to as "paper flower" because the bracts are thin and papery. The fruit '
          'is a narrow five-lobed achene.',
    };
    return bougainvillea;
  } // _bougainvillea()

  Map<String, String> _chrysanthemum() {
    final Map<String, String> chrysanthemum = {
      'title': 'Chrysanthemum',
      'genus': 'Chrysanthemum',
      'kingdom': 'Plantae',
      'order': 'Asterales',
      'family': 'Asteraceae',
      'names': 'Mums, Chrysanths',
      'intro': 'Chrysanthemums, sometimes called mums or chrysanths, are flowering '
          'plants of the genus Chrysanthemum in the family Asteraceae. They are '
          'native to Asia and northeastern Europe. Most species originate from '
          'East Asia and the center of diversity is in China. Countless horticultural '
          'varieties and cultivars exist.',
      'description': 'Wild Chrysanthemum taxa are herbaceous perennial plants or '
          'subshrubs. They have alternately arranged leaves divided into leaflets '
          'with toothed or occasionally smooth edges. The compound inflorescence '
          'is an array of several flower heads, or sometimes a solitary head. The '
          'head has a base covered in layers of phyllaries. The simple row of ray '
          'florets is white, yellow, or red; many horticultural specimens have been '
          'bred to bear many rows of ray florets in a great variety of colors. The '
          'disc florets of wild taxa are yellow. The fruit is a ribbed achene. '
          'Chrysanthemums, also known as "mums", are one of the prettiest varieties '
          'of perennials that start blooming early in the autumn. This is also known '
          'as favorite flower for the month of November.',
    };
    return chrysanthemum;
  } // _chrysanthemum()

  Map<String, String> _frangipani() {
    final Map<String, String> frangipani = {
      'title': 'Plumeria',
      'genus': 'Plumeria',
      'kingdom': 'Plantae',
      'order': 'Gentianales',
      'family': 'Apocynaceae',
      'names': 'Frangipani',
      'intro': 'Plumeria is a genus of flowering plants in the dogbane family, Apocynaceae.'
          ' Most species are deciduous shrubs or small trees. The species variously '
          'are indigenous to Thailand, Indonesia, Sri Lanka, Asia, Mexico, Central '
          'America and the Caribbean, and as far south as Brazil, but are grown '
          'as cosmopolitan ornamentals in warm regions. Common names for '
          'plants in the genus vary widely according to region, variety, and whim, '
          'but Frangipani or variations on that theme are the most common. Plumeria '
          'also is used directly as a common name, especially in horticultural circles.',
      'description': 'Plumeria flowers are most fragrant at night in order to lure '
          'sphinx moths to pollinate them. The flowers yield no nectar, however, '
          'and simply trick their pollinators. The moths inadvertently pollinate '
          'them by transferring pollen from flower to flower in their fruitless '
          'search for nectar.. Insects or human pollination can help create new '
          'varieties of plumeria. Plumeria trees from cross pollinated seeds may '
          'show characteristics of the mother tree or their flowers might just '
          'have a totally new look.',
    };
    return frangipani;
  } // _frangipani()

  Map<String, String> _fuchsia() {
    final Map<String, String> fuchsia = {
      'title': 'Fuchsia',
      'genus': 'Fuchsia',
      'kingdom': 'Plantae',
      'order': 'Myrtales',
      'family': 'Onagraceae',
      'names': 'Fuchsia',
      'intro': 'Fuchsia is a genus of flowering plants that consists mostly of '
          'shrubs or small trees. The first, Fuchsia triphylla, was discovered on '
          'the Caribbean island of Hispaniola (Haiti and the Dominican Republic) '
          'about 1696–1697 by the French Minim monk and botanist, Charles Plumier, '
          'during his third expedition to the Greater Antilles. He named the new '
          'genus after German botanist Leonhart Fuchs (1501–1566).',
      'description': 'Almost 110 species of Fuchsia are recognized; the vast majority '
          'are native to South America, but a few occur north through Central America '
          'to Mexico, and also several from New Zealand to Tahiti. One species, '
          'F. magellanica, extends as far as the southern tip of South America, '
          'occurring on Tierra del Fuego in the cool temperate zone, but the majority '
          'are tropical or subtropical. Most fuchsias are shrubs from 0.2 to 4 m '
          '(8 in to 13 ft 1 in) tall, but one New Zealand species, the kōtukutuku '
          '(F. excorticata), is unusual in the genus in being a tree, growing up '
          'to 12–15 m (39–49 ft) tall.',
    };
    return fuchsia;
  } // _fuchsia()

  Map<String, String> _heliconia() {
    final Map<String, String> heliconia = {
      'title': 'Heliconia',
      'genus': 'Heliconia',
      'kingdom': 'Plantae',
      'order': 'Zingiberales',
      'family': 'Heliconiaceae',
      'names': 'Lobster-Claws, Wild Plantains',
      'intro': 'Heliconia, is a genus of flowering plants in the family Heliconiaceae. '
          'Most of the ca 194 known species are native to the tropical Americas, '
          'but a few are indigenous to certain islands of the western Pacific and '
          'Maluku. Many species of Heliconia are found in the tropical forests of '
          'these regions. Several species are widely cultivated as ornamentals, '
          'and a few are naturalized in Florida, Gambia and Thailand. Common names '
          'for the genus include lobster-claws, toucan beak, wild plantains or '
          'false bird-of-paradise. The last term refers to their close similarity '
          'to the bird-of-paradise flowers (Strelitzia). Collectively, these plants '
          'are also simply referred to as heliconias.',
      'description': 'These herbaceous plants range from 0.5 to nearly 4.5 meters '
          '(1.5–15 feet) tall depending on the species. The simple leaves of these '
          'plants are 15–300 cm (6 in–10 ft). They are characteristically long, '
          'oblong, alternate, or growing opposite one another on non-woody petioles '
          'often longer than the leaf, often forming large clumps with age. Their '
          'flowers are produced on long, erect or drooping panicles, and consist '
          'of brightly colored waxy bracts, with small true flowers peeping out '
          'from the bracts. The growth habit of heliconias is similar to Canna, '
          'Strelitzia, and bananas, to which they are related.The flowers can be '
          'hues of reds, oranges, yellows, and greens, and are subtended by brightly '
          'colored bracts. Floral shape often limits pollination to a subset of '
          'the hummingbirds in the region.',
    };
    return heliconia;
  } // _heliconia()

  Map<String, String> _hibiscus() {
    final Map<String, String> hibiscus = {
      'title': 'Hibiscus',
      'genus': 'Hibiscus',
      'kingdom': 'Plantae',
      'order': 'Malvales',
      'family': '	Malvaceae',
      'names': 'Rose Mallow',
      'intro': 'Hibiscus is a genus of flowering plants in the mallow family, Malvaceae. '
          'The genus is quite large, comprising several hundred species that are '
          'native to warm temperate, subtropical and tropical regions throughout '
          'the world. Member species are renowned for their large, showy flowers '
          'and those species are commonly known simply as "hibiscus", or less widely '
          'known as rose mallow. There are also names for hibiscus such as hardy '
          'hibiscus, rose of sharon, and tropical hibiscus.',
      'description': 'The leaves are alternate, ovate to lanceolate, often with a '
          'toothed or lobed margin. The flowers are large, conspicuous, trumpet-shaped, '
          'with five or more petals, colour from white to pink, red, orange, peach, '
          'yellow or purple, and from 4–18 cm broad. Flower colour in certain species, '
          'such as H. mutabilis and H. tiliaceus, changes with age. The fruit is '
          'a dry five-lobed capsule, containing several seeds in each lobe, which '
          'are released when the capsule dehisces (splits open) at maturity. It is '
          'of red and white colours. It is an example of complete flowers.',
    };
    return hibiscus;
  } // _hibiscus()

  Map<String, String> _ixora() {
    final Map<String, String> ixora = {
      'title': 'Ixora',
      'genus': 'Ixora',
      'kingdom': 'Plantae',
      'order': 'Gentianales',
      'family': 'Rubiaceae',
      'names': 'Ixora',
      'intro': 'Ixora is a genus of flowering plants in the family Rubiaceae. It '
          'is the only genus in the tribe Ixoreae. It consists of tropical evergreen '
          'trees and shrubs and holds around 562 species. Though native to the '
          'tropical and subtropical areas throughout the world, its centre of diversity '
          'is in Tropical Asia. Ixora also grows commonly in subtropical climates '
          'in the United States, such as Florida where it is commonly known as '
          'West Indian Jasmine. Other common names include viruchi, rangan, kheme, '
          'ponna, chann tanea, techi, pan, siantan, jarum-jarum/jejarum, jungle flame, '
          'jungle geranium, cruz de Malta among others. The plants possess leathery '
          'leaves, ranging from 3 to 6 inches in length, and produce large clusters '
          'of tiny flowers in the summer. Members of Ixora prefer acidic soil, and '
          'are suitable choices for bonsai. It is also a popular choice for hedges '
          'in parts of South East Asia. In tropical climates they flower year round '
          'and are commonly used in Hindu worship, as well as in ayurveda and Indian '
          'folk medicine.',
      'description': '',
    };
    return ixora;
  } // _ixora()

  Map<String, String> _lantana() {
    final Map<String, String> lantana = {
      'title': 'Lantana',
      'genus': 'Lantana',
      'kingdom': 'Plantae',
      'order': 'Lamiales',
      'family': 'Verbenaceae',
      'names': 'Shrub Verbenas',
      'intro': 'Lantana is a genus of about 150 species of perennial flowering '
          'plants in the verbena family, Verbenaceae. They are native to tropical '
          'regions of the Americas and Africa but exist as an introduced species '
          'in numerous areas, especially in the Australian-Pacific region. The '
          'genus includes both herbaceous plants and shrubs growing to 0.5–2 m '
          '(1.6–6.6 ft) tall. Their common names are shrub verbenas or lantanas. '
          'The generic name originated in Late Latin, where it refers to the unrelated '
          'Viburnum lantana. Lantanas aromatic flower clusters (called umbels) '
          'are a mix of red, orange, yellow, or blue and white florets. Other '
          'colors exist as new varieties are being selected. The flowers typically '
          'change color as they mature, resulting in inflorescences that are two- '
          'or three-colored. "Wild lantanas" are plants of the unrelated genus '
          'Abronia, usually called "sand-verbenas".',
      'description': '',
    };
    return lantana;
  } // _lantana()

  Map<String, String> _pagoda() {
    final Map<String, String> pagoda = {
      'title': 'Clerodendrum',
      'genus': 'Clerodendrum',
      'kingdom': 'Plantae',
      'order': 'Lamiales',
      'family': 'Lamiaceae',
      'names': 'Pagoda Flower',
      'intro': 'The pagoda flower, (Clerodendrum paniculatum), also known as '
          'Hanuman kireetam in Hindi and Lal Vandir in Bengali, is a species of '
          'flowering plant in the genus Clerodendrum. It is native to tropical '
          'Asia and Papuasia (southern China including Taiwan, Indochina, Bangladesh, '
          'Sri Lanka, Andaman & Nicobar Islands, Borneo, Sulawesi, Sumatra, Philippines, '
          'Bismarck Archipelago). It is reportedly naturalized in India, Fiji, '
          'French Polynesia, and Central America.',
      'description': '',
    };
    return pagoda;
  } // _pagoda()

  Map<String, String> _pitcher() {
    final Map<String, String> pitcher = {
      'title': 'Nepenthes',
      'genus': 'Nepenthes',
      'kingdom': 'Plantae',
      'order': 'Caryophyllales',
      'family': 'Nepenthaceae',
      'names': 'Tropical Pitcher Plants',
      'intro': 'Nepenthes, also known as tropical pitcher plants, is a genus of '
          'carnivorous plants in the monotypic family Nepenthaceae. The genus '
          'comprises about 170 species, and numerous natural and many cultivated '
          'hybrids. They are mostly liana-forming plants of the Old World tropics, '
          'ranging from South China, Indonesia, Malaysia and the Philippines; '
          'westward to Madagascar (two species) and the Seychelles (one); southward '
          'to Australia (three) and New Caledonia (one); and northward to India (one) '
          'and Sri Lanka (one). The greatest diversity occurs on Borneo, Sumatra, '
          'and the Philippines, with many endemic species. Many are plants of hot, '
          'humid, lowland areas, but the majority are tropical montane plants, '
          'receiving warm days but cool to cold, humid nights year round. A few '
          'are considered tropical alpine, with cool days and nights near freezing. '
          'The name "monkey cups" refers to the fact that monkeys have been observed '
          'drinking rainwater from these plants.',
      'description': 'Nepenthes species usually consist of a shallow root system '
          'and a prostrate or climbing stem, often several metres long and up to '
          '15 m (49 ft) or more, and usually 1 cm (0.4 in) or less in diameter, '
          'although this may be thicker in a few species (e.g. N. bicalcarata). '
          'From the stems arise alternate, sword-shaped leaves with entire leaf '
          'margins. An extension of the midrib (the tendril), which in some species '
          'aids in climbing, protrudes from the tip of the leaf; at the end of the '
          'tendril the pitcher forms. The pitcher starts as a small bud and gradually '
          'expands to form a globe- or tube-shaped trap. The shapes can evoke a '
          'champagne flute or a condom.',
    };
    return pitcher;
  } // _pitcher()

  Map<String, String> _rafflesia() {
    final Map<String, String> rafflesia = {
      'title': 'Rafflesia',
      'genus': 'Rafflesia',
      'kingdom': 'Plantae',
      'order': 'Malpighiales',
      'family': 'Rafflesiaceae',
      'names': 'Rafflesia',
      'intro': 'Rafflesia is a genus of parasitic flowering plants. It contains '
          'approximately 28 species (including four incompletely characterized '
          'species as recognized by Willem Meijer in 1997), all found in Southeast '
          'Asia, mainly in Indonesia, Malaysia, Thailand and the Philippines. It '
          'was first discovered by Louis Deschamps in Java between 1791 and 1794, '
          'but his notes and illustrations, seized by the British in 1803, were '
          'not available to western science until 1861. It was later found in the '
          'Indonesian rainforest in Bengkulu, Sumatra by an Indonesian guide working '
          'for Joseph Arnold in 1818, and named after Sir Stamford Raffles, the '
          'leader of the expedition.',
      'description': 'The plant has no stems, leaves or roots. It is a holoparasite '
          'of vines in the genus Tetrastigma (Vitaceae), spreading its absorptive '
          'organ, the haustorium, inside the tissue of the vine. The only part of '
          'the plant that can be seen outside the host vine is the five-petalled '
          'flower. In some species, such as Rafflesia arnoldii, the flower may be '
          'over 100 centimetres (39 in) in diameter, and weigh up to 10 kilograms '
          '(22 lb). Even one of the smallest species, R. baletei, has 12 cm diameter '
          'flowers.The flowers look and smell like rotting flesh, hence its local '
          'names which translate to "corpse flower" or "meat flower". The foul '
          'odor attracts insects such as flies, which transport pollen from male '
          'to female flowers. Most species have separate male and female flowers, '
          'but a few have hermaphroditic flowers. Little is known about seed dispersal. '
          'However, tree shrews and other forest mammals eat the fruits and disperse '
          'the seeds. Rafflesia is the official state flower of Indonesia, where '
          'it is known as puspa langka (rare flower) or padma paksasa (giant flower), '
          'of Sabah state in Malaysia, and of Surat Thani Province in Thailand. '
          'In Thailand, Rafflesia can be observed in Khao Sok National Park where '
          'the flowers are numbered and monitored by the park rangers. Rafflesia '
          'are also remarkable for showing a large horizontal transfer of genes '
          'from their host plants. This is well known among bacteria, but not higher '
          'organisms.',
    };
    return rafflesia;
  } // _rafflesia()

  Map<String, String> _rhododendron() {
    final Map<String, String> rhododendron = {
      'title': 'Rhododendron',
      'genus': 'Rhododendron',
      'kingdom': 'Plantae',
      'order': 'Ericales',
      'family': 'Ericaceae',
      'names': 'Rhododendron',
      'intro': 'Rhododendron is a genus of 1,024 species of woody plants in the '
          'heath family (Ericaceae), either evergreen or deciduous, and found mainly '
          'in Asia, although it is also widespread throughout the highlands of the '
          'Appalachian Mountains of North America. It is the national flower of '
          'Nepal as well as the state flower of West Virginia and Washington. Most '
          'species have brightly coloured flowers which bloom from late winter through '
          'to early summer. Azaleas make up two subgenera of Rhododendron. They are '
          'distinguished from "true" rhododendrons by having only five anthers per flower.',
      'description': 'Rhododendron is a genus of shrubs and small to (rarely) large '
          'trees, the smallest species growing to 10–100 cm (4–40 in) tall, and '
          'the largest, R. protistum var. giganteum, reported to 30 m (100 ft) tall. '
          'The leaves are spirally arranged; leaf size can range from 1–2 cm (0.4–0.8 in) '
          'to over 50 cm (20 in), exceptionally 100 cm (40 in) in R. sinogrande. '
          'They may be either evergreen or deciduous. In some species, the undersides '
          'of the leaves are covered with scales (lepidote) or hairs (indumentum). '
          'Some of the best known species are noted for their many clusters of large '
          'flowers. There are alpine species with small flowers and small leaves, '
          'and tropical species such as section Vireya that often grow as epiphytes. '
          'Species in this genus may be part of the heath complex in oak-heath forests '
          'in eastern North America.',
    };
    return rhododendron;
  } // _rhododendron()
} // class: InfoModel