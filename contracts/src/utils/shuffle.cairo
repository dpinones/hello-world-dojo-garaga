use dojo_starter::utils::random;

fn shuffle(seed: u128, sheep_indexes: Span<u32>) -> Span<u32> {
    let mut entropy = seed;
    let mut result = array![];
    let mut i = 0;
    while i < sheep_indexes.len() {
        let sheep_index = random::get_random_card_index(entropy, sheep_indexes);
        entropy = random::LCG(entropy);
        if !contains(@result, sheep_index) {
            result.append(sheep_index);
        } else {
            continue;
        }
        i += 1;
    };
    result.span()
}

fn contains(array: @Array<u32>, value: u32) -> bool {
    let mut span = array.span();
    loop {
        match span.pop_front() {
            Option::Some(_value) => { if *_value == value {
                break true;
            } },
            Option::None => { break false; },
        }
    }
}
