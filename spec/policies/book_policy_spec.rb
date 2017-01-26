require 'rails_helper'

describe BookPolicy do
  subject { BookPolicy.new(user, book) }

  context 'for a visitor' do
    let(:user) { nil }
    let(:book) { create(:book, user: create(:user)) }

    it { should_not permit(:index)   }
    it { should_not permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:edit)    }
    it { should_not permit(:update)  }
    it { should_not permit(:destroy) }
  end

  context 'for a user' do
    let(:user) { create(:user) }
    let(:book) { create(:book, user: create(:user)) }

    it { should permit(:index)       }
    it { should_not permit(:show)    }
    it { should permit(:create)      }
    it { should permit(:new)         }
    it { should_not permit(:edit)    }
    it { should_not permit(:update)  }
    it { should_not permit(:destroy) }
  end

  context 'for a author' do
    let(:user) { create(:user) }
    let(:book) { create(:book, user: user) }

    it { should permit(:index)   }
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:edit)    }
    it { should permit(:update)  }
    it { should permit(:destroy) }
  end
end