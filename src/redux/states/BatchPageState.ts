
export class BatchPageState {
    
    public static defaultKinasesStr(): string {
        return  `Q15796,K,19
Q15796,T,8
P04637,K,120
P04637,S,140
P04637,S,378
P04637,S,392
P04637,S,199`;
    }

    public readonly kinasesStr: string;

    constructor() {
        this.kinasesStr = "";
    }
   
}

