class CostRange < ApplicationRecord

    def name
        return self.currency+" "+self.range1.to_s+"-"+self.range2.to_s
    end
    
end
