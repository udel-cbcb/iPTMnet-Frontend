export class HomePageState {
    public readonly selectedPTMs: string[]

    constructor(){
        this.selectedPTMs = []
    }

}

export const initialState: HomePageState = new HomePageState();