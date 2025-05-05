use dojo_starter::utils::random;

fn shuffle(seed: u128, sheep_indexes: Span<u32>) -> Span<u32> {
    let mut entropy = seed;
    let mut result = array![];
    let mut i = 0;
    println!("sheep_indexes.len(): {}", sheep_indexes.len());
    while i < sheep_indexes.len() {
        let sheep_index = random::get_random_card_index(entropy, sheep_indexes);
        entropy = random::LCG(entropy);
        println!("sheep_index: {}", sheep_index);
        println!("result.len(): {}", result.len());
        if !contains(@result, sheep_index) {
            println!("entro");
            result.append(sheep_index);
        } else {
            println!("no entro");
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
