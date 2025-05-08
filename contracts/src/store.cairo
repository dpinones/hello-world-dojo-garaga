use dojo::{model::ModelStorage, world::WorldStorage};

use dojo_starter::models::{Cell, Game, Round};


#[derive(Drop)]
pub struct Store {
    world: WorldStorage,
}

#[generate_trait]
pub impl StoreImpl of StoreTrait {
    #[inline(always)]
    fn new(ref world: WorldStorage) -> Store {
        Store { world: world }
    }

    fn get_game(ref self: Store, id: u32) -> Game {
        self.world.read_model(id)
    }

    fn set_game(ref self: Store, game: Game) {
        self.world.write_model(@game)
    }

    fn get_round(ref self: Store, game_id: u32) -> Round {
        self.world.read_model(game_id)
    }

    fn set_round(ref self: Store, round: Round) {
        self.world.write_model(@round)
    }

    fn get_cell(ref self: Store, game_id: u32, idx: u32) -> Cell {
        self.world.read_model((game_id, idx))
    }

    fn set_cell(ref self: Store, cell: Cell) {
        self.world.write_model(@cell)
    }
}
