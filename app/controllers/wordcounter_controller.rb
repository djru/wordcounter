class WordcounterController < ApplicationController
  skip_before_action :verify_authenticity_token

  def count
    file = params[:text]
    if file.content_type != 'application/pdf'
      redirect_to :root, notice: 'file was not pdf'
    else
      opened_pdf = PDF::Reader.new file.tempfile
      contents = opened_pdf.pages.join(" ")
      @freqs = analyze(contents)
    end
  end

  def count_manual
    @freqs = analyze(params[:text_manual])
  end

  private

  def sanitize word
    conj = common_conjunctions[word]
    # if there is an alternate conjugation, use the simplified form
    if conj
      conj
    # if the word ends in s, ed, ing, or 's, get rid of the suffix
    else
      word.gsub(/(?<=\w)(ed|ing|'s|(?<!s)s)\b/i, '')
    end
  end
  def analyze text
    text_nodes = text.strip.downcase.split(/[,.+&?!\s]+/i )
    word_count = {}
    text_nodes.each do |word|
      word = sanitize(word)
      if word_count[word]
         word_count[word] += 1
      else
        word_count[word] = 1
      end
    end

    return Hash[word_count.sort_by{|k, v| -v}.first(50)]
  end

  def common_conjunctions
    return {
      'abode' => 'abide',
      'arose' => 'arise',
      'awoke' => 'awake',
      'are' => 'is',
      'an' => 'a',
      'bore' => 'bear',
      'beat' => 'beat',
      'became' => 'become',
      'begat' => 'beget',
      'be' => 'is',
      'began' => 'begin',
      'bent' => 'bend',
      'besought' => 'beseech',
      'betted' => 'bet',
      'bade' => 'bid',
      'bound' => 'bind',
      'bit' => 'bite',
      'bled' => 'bleed',
      'blew' => 'blow',
      'broke' => 'break',
      'bred' => 'breed',
      'brought' => 'bring',
      'built' => 'build',
      'bought' => 'buy',
      'could' => 'can',
      'cast' => 'cast',
      'caught' => 'catch',
      'chid' => 'chide',
      'chose' => 'choose',
      'cleft' => 'cleave',
      'clung' => 'cling',
      'came' => 'come',
      'crept' => 'creep',
      'cut' => 'cut',
      'dealt' => 'deal',
      'dug' => 'dig',
      'dove' => 'dive',
      'did' => 'do',
      'drew' => 'draw',
      'dreamt' => 'dream',
      'drank' => 'drink',
      'drove' => 'drive',
      'dwelt' => 'dwell',
      'ate' => 'eat',
      'fell' => 'fall',
      'fed' => 'feed',
      'felt' => 'feel',
      'fought' => 'fight',
      'found' => 'find',
      'fled' => 'flee',
      'flung' => 'fling',
      'flew' => 'fly',
      'forbade' => 'forbid',
      'forgot' => 'forget',
      'forsook' => 'forsake',
      'froze' => 'freeze',
      'got' => 'get',
      'gilded' => 'gild',
      'girt' => 'gird',
      'gave' => 'give',
      'went' => 'go',
      'ground' => 'grind',
      'grew' => 'grow',
      'hung' => 'hang',
      'had' => 'have',
      'heard' => 'hear',
      'hove' => 'heave',
      'hewed' => 'hew',
      'hid' => 'hide',
      'hit' => 'hit',
      'held' => 'hold',
      'hurt' => 'hurt',
      'kept' => 'keep',
      'knelt' => 'kneel',
      'knew' => 'know',
      'laded' => 'lade',
      'laid' => 'lay',
      'led' => 'lead',
      'leant' => 'lean',
      'leapt' => 'leap',
      'learnt' => 'learn',
      'left' => 'leave',
      'lent' => 'lend',
      'let' => 'let',
      'lay' => 'lie',
      'lied' => 'lie',
      'lit' => 'light',
      'lost' => 'lose',
      'made' => 'make',
      'might' => 'may',
      'meant' => 'mean',
      'met' => 'meet',
      'mowed' => 'mow',
      'paid' => 'pay',
      'put' => 'put',
      'read' => 'read',
      'rent' => 'rend',
      'ridded' => 'rid',
      'rode' => 'ride',
      'rang' => 'ring',
      'rose' => 'rise',
      'ran' => 'run',
      'sawed' => 'saw',
      'said' => 'say',
      'saw' => 'see',
      'sought' => 'seek',
      'sold' => 'sell',
      'sent' => 'send',
      'set' => 'set',
      'sewed' => 'sew',
      'shook' => 'shake',
      'shaved' => 'shave',
      'sheared' => 'shear',
      'shed' => 'shed',
      'shone' => 'shine',
      'shone' => 'shine',
      'shod' => 'shoe',
      'shot' => 'shoot',
      'showed' => 'show',
      'shrank' => 'shrink',
      'shut' => 'shut',
      'sang' => 'sing',
      'sank' => 'sink',
      'sat' => 'sit',
      'slew' => 'slay',
      'slept' => 'sleep',
      'slid' => 'slide',
      'slung' => 'sling',
      'slunk' => 'slink',
      'slitted' => 'slit',
      'smelt' => 'smell',
      'smote' => 'smite',
      'sowed' => 'sow',
      'spoke' => 'speak',
      'sped' => 'speed',
      'spelt' => 'spell',
      'spent' => 'spend',
      'spilt' => 'spill',
      'spun' => 'spin',
      'spat' => 'spit',
      'spitted' => 'spit',
      'split' => 'split',
      'spoilt' => 'spoil',
      'spread' => 'spread',
      'sprang' => 'spring',
      'stood' => 'stand',
      'stove' => 'stave',
      'stole' => 'steal',
      'stuck' => 'stick',
      'stung' => 'sting',
      'stank' => 'stink',
      'strewed' => 'strew',
      'strode' => 'stride',
      'struck' => 'strike',
      'strung' => 'string',
      'strove' => 'strive',
      'swore' => 'swear',
      'swept' => 'sweep',
      'swelled' => 'swell',
      'swam' => 'swim',
      'swung' => 'swing',
      'took' => 'take',
      'taught' => 'teach',
      'tore' => 'tear',
      'told' => 'tell',
      'thought' => 'think',
      'throve' => 'thrive',
      'threw' => 'throw',
      'thrust' => 'thrust',
      'trod' => 'tread',
      'was' => 'is',
      'woke' => 'wake',
      'wore' => 'wear',
      'wove' => 'weave',
      'wept' => 'weep',
      'won' => 'win',
      'wound' => 'wind',
      'wrung' => 'wring',
      'wrote' => 'write'
    }
  end

end
